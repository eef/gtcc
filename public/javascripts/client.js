var CONFIG = { debug: false
             , username: "#"   // set in onConnect
             , change_page: false
             , id: null    // set in onConnect
             , last_message_time: 1
             , focus: true //event listeners bound in onConnect
             , unread: 0 //updated in the message-processing loop
             };

var usernames = [];

//  CUT  ///////////////////////////////////////////////////////////////////
/* This license and copyright apply to all code until the next "CUT"
http://github.com/jherdman/javascript-relative-time-helpers/

The MIT License

Copyright (c) 2009 James F. Herdman

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


 * Returns a description of this past date in relative terms.
 * Takes an optional parameter (default: 0) setting the threshold in ms which
 * is considered "Just now".
 *
 * Examples, where new Date().toString() == "Mon Nov 23 2009 17:36:51 GMT-0500 (EST)":
 *
 * new Date().toRelativeTime()
 * --> 'Just now'
 *
 * new Date("Nov 21, 2009").toRelativeTime()
 * --> '2 days ago'
 *
 * // One second ago
 * new Date("Nov 23 2009 17:36:50 GMT-0500 (EST)").toRelativeTime()
 * --> '1 second ago'
 *
 * // One second ago, now setting a now_threshold to 5 seconds
 * new Date("Nov 23 2009 17:36:50 GMT-0500 (EST)").toRelativeTime(5000)
 * --> 'Just now'
 *
 */
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
    millisecond: 1, // ms    -> ms
    second: 1000,   // ms    -> sec
    minute: 60,     // sec   -> min
    hour:   60,     // min   -> hour
    day:    24,     // hour  -> day
    month:  30,     // day   -> month (roughly)
    year:   12      // month -> year
  };

  for (var key in conversions) {
    if (delta < conversions[key]) {
      break;
    } else {
      units = key; // keeps track of the selected key over the iteration
      delta = delta / conversions[key];
    }
  }

  // pluralize a unit when the difference is greater than 1.
  delta = Math.floor(delta);
  if (delta !== 1) { units += "s"; }
  return [delta, units].join(" ");
};

/*
 * Wraps up a common pattern used with this plugin whereby you take a String
 * representation of a Date, and want back a date object.
 */
Date.fromString = function(str) {
  return new Date(Date.parse(str));
};

//  CUT  ///////////////////////////////////////////////////////////////////



//updates the users link to reflect the number of active users
function updateUsersLink ( ) {
  var t = usernames.length.toString() + " user";
  if (usernames.length != 1) t += "s";
  $("#usersLink").text(t);
}

//handles another person joining chat
function userJoin(username, timestamp) {
  //put it in the stream
  addMessage(username, "joined", timestamp, "join");
  //if we already know about this user, ignore it
  for (var i = 0; i < usernames.length; i++)
    if (usernames[i] == username) return;
  //otherwise, add the user to the list
  usernames.push(username);
  //update the UI
  updateUsersLink();
}

//handles someone leaving
function userPart(username, timestamp) {
  //put it in the stream
  addMessage(username, "left", timestamp, "part");
  //remove the user from the list
  for (var i = 0; i < usernames.length; i++) {
    if (usernames[i] == username) {
      usernames.splice(i,1)
      break;
    }
  }
  //update the UI
  updateUsersLink();
}

// utility functions

util = {
  urlRE: /https?:\/\/([-\w\.]+)+(:\d+)?(\/([^\s]*(\?\S+)?)?)?/g, 

  //  html sanitizer 
  toStaticHTML: function(inputHtml) {
    inputHtml = inputHtml.toString();
    return inputHtml.replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;");
  }, 

  //pads n with zeros on the left,
  //digits is minimum length of output
  //zeroPad(3, 5); returns "005"
  //zeroPad(2, 500); returns "500"
  zeroPad: function (digits, n) {
    n = n.toString();
    while (n.length < digits) 
      n = '0' + n;
    return n;
  },

  //it is almost 8 o'clock PM here
  //timeString(new Date); returns "19:49"
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

      // the above dt.get...() functions return a single digit
      // so I prepend the zero here when needed
      if (hours < 10) 
       hours = '0' + hours;

      if (minutes < 10) 
       minutes = '0' + minutes;

      if (seconds < 10) 
       seconds = '0' + seconds;

      return hours + ":" + minutes;
  },

  //does the argument only contain whitespace?
  isBlank: function(body_content) {
    var blank = /^\s*$/;
    return (body_content.match(blank) !== null);
  }
};

//used to keep the most recent messages visible
function scrollDown () {
  $("#log").scrollTop($("#log").scrollTop() + 50000);
}

//inserts an event into the stream for display
//the event may be a msg, join or part type
//from is the user, text is the body and time is the timestamp, defaulting to now
//_class is a css class to apply to the message, usefull for system events
function addMessage (from, body_content, time, _class) {
  if (typeof(time) == "string") {
    time = parseInt(time);
  };
  if (body_content === null)
    return;

  if (time == null) {
    // if the time is null or undefined, use the current time.
    time = (new Date()).getTime();
  }
  

  //every message you see is actually a table with 3 cols:
  //  the time,
  //  the person who caused the event,
  //  and the content
  var messageElement = $(document.createElement("div"));

  messageElement.addClass("message");
  if (_class)
    messageElement.addClass(_class);

  // sanitize
  body_content = util.toStaticHTML(body_content);

  // If the current user said this, add a special css class
  var username_re = new RegExp(CONFIG.username);
  if (username_re.exec(body_content))
    messageElement.addClass("personal");

  // replace URLs with links
  body_content = body_content.replace(util.urlRE, '<a target="_blank" href="$&">$&</a>');

  var content = '  <div class="message-holder">'
              + '    <div class="message-date">' + util.formatTime(time) + "</div>"
              + '    <div class="message-content">'+ util.toStaticHTML(from) +': ' + body_content + "</div>"
              + '  </div>'
              ;
  messageElement.html(content);

  //the log is the stream that we view
  $("#log").append(messageElement);

  //always view the most recent message when it is added
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


//process updates if we have any, request updates from the server,
// and call again with response. the last part is like recursion except the call
// is being made from the response handler, and not at some point during the
// function's execution.
function longPoll (data) {
  if (transmission_errors > 2) {
    showConnect();
    return;
  }

  if (data && data.rss) {
    rss = data.rss;
    updateRSS();
  }

  //process any updates we may have
  //data will be null on the first call of longPoll
  if (data && data.messages) {
    for (var i = 0; i < data.messages.length; i++) {
      var message = data.messages[i];

      //track oldest message so we only request newer messages from server
      if (message.timestamp > CONFIG.last_message_time)
        CONFIG.last_message_time = message.timestamp;

      //dispatch new messages to their appropriate handlers
      switch (message.type) {
        case "msg":
          if(!CONFIG.focus){
            CONFIG.unread++;
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
    //update the document title to include unread message count if blurred
    updateTitle();

    //only after the first request for messages do we want to show who is here
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

  //make another request
  $.ajax({ cache: false
         , type: "GET"
         , url: "/recv"
         , dataType: "json"
         , data: { since: CONFIG.last_message_time, id: CONFIG.id, changed: changed }
         , error: function () {
             addMessage("", "long poll error. trying again...", (new Date()).getTime(), "error");
             transmission_errors += 1;
             //don't flood the servers on error, wait 10 seconds before retrying
             setTimeout(longPoll, 10*1000);
           }
         , success: function (data) {
             transmission_errors = 0;
             //if everything went well, begin another request immediately
             //the server will take a long time to respond
             //how long? well, it will wait until there is another message
             //and then it will return it to us and close the connection.
             //since the connection is closed when we get data, we longPoll again
             longPoll(data);
           }
         });
}

//submit a new message to the server
function send(msg) {
  if (CONFIG.debug === false) {
    // XXX should be POST
    // XXX should add to messages immediately
    jQuery.get("/send", {id: CONFIG.id, body_content: msg}, function (data) { }, "json");
  }
}

//Transition the page to the state that prompts the user for a nickname
function showConnect () {
  $("#connect").removeClass("hidden").show();
  $("#loading").hide();
  $("#toolbar").hide();
  $("#nickInput").focus();
}

//transition the page to the loading screen
function showLoad () {
  $("#connect").hide();
  $("#loading").show();
  $("#toolbar").hide();
}

//transition the page to the main chat view, putting the cursor in the textfield
function showChat (username) {
  console.log("ShowChat");
  $("#toolbar").removeClass("hidden").show();
  $("#entry").removeClass("hidden").show();
  $("#entry").focus();

  $("#connect").hide();
  $("#loading").hide();

  scrollDown();
}

//we want to show a count of unread messages when the window does not have focus
function updateTitle(){
  if (CONFIG.unread) {
    document.title = "(" + CONFIG.unread.toString() + ") node chat";
  } else {
    document.title = "node chat";
  }
}

// daemon start time
var starttime;
// daemon memory usage
var rss;

//handle the server's response to our nickname and join request
function onConnect (session) {
  if (session.error) {
    alert("error connecting: " + session.error);
    showConnect();
    return;
  }
  $("#log").removeClass("hidden").slideDown();
  $("#log").scrollTop($("#log").scrollTop() + 50000);
  CONFIG.username = session.username;
  CONFIG.id   = session.id;
  $.cookie('chat_id', session.id);
  $.cookie('chat_username', session.username);
  starttime   = new Date(session.starttime);
  rss         = session.rss;
  updateRSS();
  updateUptime();

  //update the UI to show the chat
  showChat(CONFIG.username);

  //listen for browser events so we know to update the document title
  $(window).bind("blur", function() {
    CONFIG.focus = false;
    updateTitle();
  });

  $(window).bind("focus", function() {
    CONFIG.focus = true;
    CONFIG.unread = 0;
    updateTitle();
  });
}

//add a list of present chat members to the stream
function outputUsers () {
  var username_string = usernames.length > 0 ? usernames.join(", ") : "(none)";
  addMessage("users", username_string, (new Date()).getTime(), "notice");
  return false;
}

//get a list of the users presently in the room, and add it to the stream
function who () {
  jQuery.get("/who", {}, function (data, status) {
    if (status != "success") return;
    usernames = data.usernames;
    outputUsers();
  }, "json");
}

$(document).ready(function() {

  //submit new messages when the user hits enter if the message isnt blank
  $("#entry").keypress(function (e) {
    if (e.keyCode != 13 /* Return */) return;
    var msg = $("#entry").attr("value").replace("\n", "");
    if (!util.isBlank(msg)) send(msg);
    $("#entry").attr("value", ""); // clear the entry field.
  });

  $("#usersLink").click(outputUsers);
  if($.cookie('chat_id').length > 0) {
    console.log("Got here");
    CONFIG.id = $.cookie('chat_id');
    CONFIG.username = $.cookie('chat_username');
    CONFIG.change_path = true;
    $.cookie('chat_id', null);
    $.cookie('chat_username', null);
    $("#log").removeClass("hidden").slideDown();
    $("#connect").hide();
    $("#toolbar").removeClass("hidden").show();
    $("#entry").focus();
    showChat(CONFIG.username);
  } else {
    console.log("sads");
    showConnect();
  }
  console.log("going");
  $("a").click(function(){
    if(CONFIG.id != null) {
     $.cookie('chat_id', CONFIG.id);
     $.cookie('chat_username', CONFIG.username);
    }
  });

  //try joining the chat when the user clicks the connect button
  $("#connectButton").click(function () {
    //lock the UI while waiting for a response
    showLoad();
    var username = $("#nickInput").attr("value");

    //dont bother the backend if we fail easy validations
    if (username.length > 50) {
      alert("username too long. 50 character max.");
      showConnect();
      return false;
    }

    //more validations
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

  // update the daemon uptime every 10 seconds
  setInterval(function () {
    updateUptime();
  }, 10*1000);

  if (CONFIG.debug) {
    $("#loading").hide();
    $("#connect").hide();
    scrollDown();
    return;
  }

  // remove fixtures
  $("#log table").remove();

  //begin listening for updates right away
  //interestingly, we don't need to join a room to get its updates
  //we just don't show the chat stream to the user until we create a session
  longPoll();
  
});

//if we can, notify the server that we're going away.
$(window).unload(function () {
  if(!$.cookie("chat_id").length > 0) {
    alert("parting");
   jQuery.get("/part", {id: CONFIG.id}, function (data) { }, "json");
  }
});
