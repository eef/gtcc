var CONFIG = { debug: false, username: "#", change_page: false, id: null, last_message_time: 1, focus: true , unread: 0, unread_p: 0};

var usernames = [];

Date.prototype.toRelativeTime = function(now_threshold) {
  var delta = new Date() - this;

  now_threshold = parseInt(now_threshold, 10);

  if (isNaN(now_threshold)) {
    now_threshold = 0;
  }

  if (delta <= now_threshold) {
    return 'Just now';
  }

  var units = null;
  var conversions = {
    millisecond: 1, 
    second: 1000,   
    minute: 60,     
    hour:   60,     
    day:    24,     
    month:  30,     
    year:   12      
  };

  for (var key in conversions) {
    if (delta < conversions[key]) {
      break;
    } else {
      units = key;
      delta = delta / conversions[key];
    }
  }

  delta = Math.floor(delta);
  if (delta !== 1) { units += "s"; }
  return [delta, units].join(" ");
};

Date.fromString = function(str) {
  return new Date(Date.parse(str));
};

function updateUsersLink ( ) {
  var t = usernames.length.toString() + " user";
  if (usernames.length != 1) t += "s";
  $("#usersLink").text(t);
}

function update_user_list() {
  var usrs = "";
  $.each(usernames, function(idx, username){
    usrs += "<li>" + username + "</li>";
  });
  $("#user-list").html(usrs);
}

function userJoin(username, timestamp) {
  addMessage(username, "joined the chat", timestamp, "join");
  for (var i = 0; i < usernames.length; i++)
    if (usernames[i] == username) return;
  usernames.push(username);
  updateUsersLink();
  update_user_list();
}

function userPart(username, timestamp) {
  addMessage(username, "left the chat", timestamp, "part");
  for (var i = 0; i < usernames.length; i++) {
    if (usernames[i] == username) {
      usernames.splice(i,1)
      break;
    }
  }
  update_user_list();
  updateUsersLink();
}


util = {
  urlRE: /https?:\/\/([-\w\.]+)+(:\d+)?(\/([^\s]*(\?\S+)?)?)?/g, 

  toStaticHTML: function(inputHtml) {
    inputHtml = inputHtml.toString();
    return inputHtml.replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;");
  }, 

  zeroPad: function (digits, n) {
    n = n.toString();
    while (n.length < digits) 
      n = '0' + n;
    return n;
  },

  timeString: function (date) {
    var minutes = date.getMinutes().toString();
    var hours = date.getHours().toString();
    return this.zeroPad(2, hours) + ":" + this.zeroPad(2, minutes);
  },
  
  formatTime: function(unixTimestamp) {
      var dt = new Date(unixTimestamp);

      var hours = dt.getHours();
      var minutes = dt.getMinutes();
      var seconds = dt.getSeconds();

      if (hours < 10) 
       hours = '0' + hours;

      if (minutes < 10) 
       minutes = '0' + minutes;

      if (seconds < 10) 
       seconds = '0' + seconds;

      return hours + ":" + minutes;
  },

  isBlank: function(body_content) {
    var blank = /^\s*$/;
    return (body_content.match(blank) !== null);
  }
};

function scrollDown () {
  $("#log").scrollTop($("#log").scrollTop() + 50000);
}

function addMessage (from, body_content, time, _class) {
  if (typeof(time) == "string") {
    time = parseInt(time);
  };
  if (body_content === null)
    return;

  if (time == null) {
    time = (new Date()).getTime();
  }
  
  if(_class == null) {
    from += ":";
  }
  
  var messageElement = $(document.createElement("div"));

  messageElement.addClass("message");
  if (_class)
    messageElement.addClass(_class);

  body_content = util.toStaticHTML(body_content);

  var username_re = new RegExp(CONFIG.username, "i");
  if (username_re.exec(body_content))
    messageElement.addClass("personal");

  // replace URLs with links
  body_content = body_content.replace(util.urlRE, '<a target="_blank" href="$&">$&</a>');

  var content = '  <div class="message-holder">'
              + '    <div class="message-date">' + util.formatTime(time) + "</div>"
              + '    <div class="message-content"><span class="username-lab">'+ util.toStaticHTML(from) +'</span> ' + body_content + "</div>"
              + '  </div>'
              ;
  messageElement.html(content);

  $("#log").append(messageElement);

  scrollDown();
}

function updateRSS () {
  var bytes = parseInt(rss);
  if (bytes) {
    var megabytes = bytes / (1024*1024);
    megabytes = Math.round(megabytes*10)/10;
    $("#rss").text(megabytes.toString());
  }
}

function updateUptime () {
  if (starttime) {
    $("#uptime").text(starttime.toRelativeTime());
  }
}

var transmission_errors = 0;
var first_poll = true;

function longPoll (data) {
  if (transmission_errors > 2) {
    showConnect();
    return;
  }

  if (data && data.rss) {
    rss = data.rss;
    updateRSS();
  }

  if (data && data.messages) {
    for (var i = 0; i < data.messages.length; i++) {
      var message = data.messages[i];

      if (message.timestamp > CONFIG.last_message_time)
        CONFIG.last_message_time = message.timestamp;

      switch (message.type) {
        case "msg":
          if(!CONFIG.focus){
            CONFIG.unread++;
          }
          if(!first_poll) {
            if($.cookie("chat") == "closed") {
              CONFIG.unread_p++;
            }
          }
          addMessage(message.username, message.body_content, message.timestamp);
          break;

        case "join":
          userJoin(message.username, message.timestamp);
          break;

        case "part":
          userPart(message.username, message.timestamp);
          break;
      }
    }
    updateTitle();

    if (first_poll) {
      first_poll = false;
      who();
    }
  }
  changed = "no";
  if(CONFIG.page_change) {
    CONFIG.page_change = false;
    changed = "yes";
  }

  $.ajax({ cache: false
         , type: "GET"
         , url: "/recv"
         , dataType: "json"
         , data: { since: CONFIG.last_message_time, id: CONFIG.id, changed: changed }
         , error: function () {
            if($.cookie("switch") == "0") {
              addMessage("", "long poll error. trying again...", (new Date()).getTime(), "error"); 
            }
             transmission_errors += 1;
             setTimeout(longPoll, 10*1000);
           }
         , success: function (data) {
             transmission_errors = 0;
             longPoll(data);
           }
         });
}

function send(msg) {
  if (CONFIG.debug === false) {
    jQuery.get("/send", {id: CONFIG.id, body_content: msg}, function (data) { }, "json");
  }
}

function showConnect () {
  $("#connect").removeClass("hidden").show();
  $("#loading").hide();
  $("#toolbar").hide();
  $("#nickInput").focus();
}

function showLoad () {
  $("#connect").hide();
  $("#loading").show();
  $("#toolbar").hide();
}

function showChat (username) {
  $("#toolbar").removeClass("hidden").show();
  $("#entry").removeClass("hidden").show();
  $("#entry").focus();

  $("#connect").hide();
  $(".stats").hide();
  $("#loading").hide();

  scrollDown();
}

function updateTitle(){
  if (CONFIG.unread) {
    document.title = "(" + CONFIG.unread.toString() + ") Gran Turismo Racing - GTR ";
  } else {
    document.title = "Gran Turismo Racing - GTR";
  }
  if (CONFIG.unread_p > 0) {
    $("#new-msg").text("(" + CONFIG.unread_p.toString() + ") Open chat ");
  } else {
    $("#new-msg").text("Open chat");
  }
}


var starttime;

var rss;

function onConnect (session) {
  if (session.error) {
    alert("error connecting: " + session.error);
    showConnect();
    return;
  }
  $("#chat-panel").removeClass("hidden").slideDown();
  $("#log").scrollTop($("#log").scrollTop() + 50000);
  CONFIG.username = session.username;
  CONFIG.id   = session.id;
  starttime   = new Date(session.starttime);
  rss         = session.rss;
  updateRSS();
  updateUptime();
  update_user_list();
  showChat(CONFIG.username);
  $.cookie('chat', "open");
}

function who () {
  jQuery.get("/who", {}, function (data, status) {
    if (status != "success") return;
    usernames = data.usernames;
    update_user_list();
  }, "json");
}

$(document).ready(function() {

  $("#entry").keypress(function (e) {
    if (e.keyCode != 13 /* Return */) return;
    var msg = $("#entry").attr("value").replace("\n", "");
    if (!util.isBlank(msg)) send(msg);
    $("#entry").attr("value", "");
  });
  
  if($.cookie('chat_id').length > 0) {
    CONFIG.id = $.cookie('chat_id');
    CONFIG.username = $.cookie('chat_username');
    CONFIG.change_path = true;
    $.cookie('chat_id', null);
    $.cookie('chat_username', null);
    $.cookie('switch', "0");
    if($.cookie('chat').length > 0) {
      if($.cookie('chat') == "open") {
        $("#chat-panel").removeClass("hidden").slideDown();
      }
      if($.cookie('chat') == "closed") {
        $("#app").hide();
        $("#show-chat").removeClass("hidden").show("fast");
      }
    }
    $("#connect").hide();
    $(".stats").hide();
    $("#toolbar").removeClass("hidden").show();
    $("#entry").focus();
    $(window).bind("blur", function() {
      CONFIG.focus = false;
      updateTitle();
    });

    $(window).bind("focus", function() {
      CONFIG.focus = true;
      CONFIG.unread = 0;
      updateTitle();
    });
    showChat(CONFIG.username);
  } else {
    showConnect();
  }
  $("a").click(function(){
    if(CONFIG.id != null) {
     $.cookie('chat_id', CONFIG.id);
     $.cookie('chat_username', CONFIG.username);
     $.cookie('switch', "1");
    }
  });
  
  $("#close-chat").click(function(){
    $.cookie('chat', "closed");
    $("#app").hide();
    $("#show-chat").removeClass("hidden").show();
  });
  $("#new-msg").click(function(){
    $.cookie('chat', "open");
    $("#chat-panel").removeClass("hidden").show();
    $("#app").show();
    $("#show-chat").hide();
    $(this).text("Open chat");
    scrollDown();
  });

  $("#connectButton").click(function () {
    showLoad();
    var username = $("#nickInput").attr("value");

    if (username.length > 50) {
      alert("username too long. 50 character max.");
      showConnect();
      return false;
    }

    if (/[^\w_\-^!]/.exec(username)) {
      alert("Bad character in username. Can only have letters, numbers, and '_', '-', '^', '!'");
      showConnect();
      return false;
    }

    //make the actual join request to the server
    $.ajax({ cache: false
           , type: "GET" // XXX should be POST
           , dataType: "json"
           , url: "/join"
           , data: { username: username }
           , error: function () {
               alert("error connecting to server");
               showConnect();
             }
           , success: onConnect
           });
    return false;
  });

  setInterval(function () {
    updateUptime();
  }, 10*1000);

  if (CONFIG.debug) {
    $("#loading").hide();
    $("#connect").hide();
    scrollDown();
    return;
  }

  $("#log table").remove();
  longPoll();
  
});

$(window).unload(function () {
  if(!$.cookie("chat_id").length > 0) {
   jQuery.get("/part", {id: CONFIG.id}, function (data) { }, "json");
  }
});
