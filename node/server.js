HOST = null; // localhost
PORT = 8001;

// when the daemon started
var starttime = (new Date()).getTime();

var mem = process.memoryUsage();
// every 10 seconds poll for the memory.
setInterval(function () {
  mem = process.memoryUsage();
}, 10*1000);


var fu = require("./fu"),
    sys = require("sys"),
    url = require("url"),
    mongoose = require('mongoose');
    require("./schema");
    qs = require("querystring");
    mongoose.connect('mongodb://localhost/chat_gtcc');;
    var Message = mongoose.model("Message");

var MESSAGE_BACKLOG = 200,
    SESSION_TIMEOUT = 60 * 1000;

var channel = new function () {
  var messages = [],
      callbacks = [];
  Message.find({"type":"msg"}, function (err, docs) {
    docs.forEach(function(doc){
      messages.push(doc);
    });
  });
      
  this.append_message = function(username, type, body_content) {
    var timestamp = (new Date()).getTime();
    var message = {username: username, type: type, body_content: body_content, timestamp: timestamp};
      
    var record = new Message();
    record.username = username;
    record.type = type;
    record.body_content = body_content;
    record.timestamp = timestamp;
    record.save(function (err) {
      messages.push(message);
    });
    while (callbacks.length > 0) {
      callbacks.shift().callback([message]);
    }
  }

  this.query = function (since, callback) {
    var matching = [];
    for (var i = 0; i < messages.length; i++) {
      var message = messages[i];
      if (message.timestamp > since)
        matching.push(message)
    }

    if (matching.length != 0) {
      callback(matching);
    } else {
      callbacks.push({ timestamp: new Date(), callback: callback });
    }
  };

  // clear old callbacks
  // they can hang around for at most 30 seconds.
  setInterval(function () {
    var now = new Date();
    while (callbacks.length > 0 && now - callbacks[0].timestamp > 30*1000) {
      callbacks.shift().callback([]);
    }
  }, 3000);
};

var sessions = {};

function createSession (username) {
  if (username.length > 50) return null;
  if (/[^\w_\-^!]/.exec(username)) return null;

  for (var i in sessions) {
    var session = sessions[i];
    if (session && session.username === username) return null;
  }

  var session = { 
    username: username, 
    id: Math.floor(Math.random()*99999999999).toString(),
    timestamp: new Date(),

    poke: function () {
      session.timestamp = new Date();
    },

    destroy: function () {
      sys.puts("Start destroy session");
      channel.append_message(session.username, "part", 'left');
      delete sessions[session.id];
    }
  };

  sessions[session.id] = session;
  return session;
}

// interval to kill off old sessions
setInterval(function () {
  var now = new Date();
  for (var id in sessions) {
    if (!sessions.hasOwnProperty(id)) continue;
    var session = sessions[id];

    if (now - session.timestamp > SESSION_TIMEOUT) {
      session.destroy();
    }
  }
}, 1000);

fu.listen(Number(process.env.PORT || PORT), HOST);

fu.get("/", fu.staticHandler("index.html"));
fu.get("/style.css", fu.staticHandler("style.css"));
fu.get("/client.js", fu.staticHandler("client.js"));
fu.get("/jquery-1.2.6.min.js", fu.staticHandler("jquery-1.2.6.min.js"));


fu.get("/who", function (req, res) {
  var usernames = [];
  for (var id in sessions) {
    if (!sessions.hasOwnProperty(id)) continue;
    var session = sessions[id];
    usernames.push(session.username);
  }
  res.simpleJSON(200, { usernames: usernames
                      , rss: mem.rss
                      });
});

fu.get("/join", function (req, res) {
  var username = qs.parse(url.parse(req.url).query).username;
  if (username == null || username.length == 0) {
    res.simpleJSON(400, {error: "Bad username."});
    return;
  }
  var session = createSession(username);
  if (session == null) {
    res.simpleJSON(400, {error: "Username in use"});
    return;
  }

  //sys.puts("connection: " + nick + "@" + res.connection.remoteAddress);

  channel.append_message(session.username, "join", "joined");
  res.simpleJSON(200, { id: session.id
                      , username: session.username
                      , rss: mem.rss
                      , starttime: starttime
                      });
});

fu.get("/part", function (req, res) {
  var id = qs.parse(url.parse(req.url).query).id;
  sys.puts("ID: " + id);
  var session;
  if (id && sessions[id]) {
    sys.puts("ID && sessions[id] exists")
    session = sessions[id];
    session.destroy();
  }
  res.simpleJSON(200, { rss: mem.rss });
});

fu.get("/recv", function (req, res) {
  if (!qs.parse(url.parse(req.url).query).since) {
    res.simpleJSON(400, { error: "Must supply since parameter" });
    return;
  }
  var id = qs.parse(url.parse(req.url).query).id;
  var changed = qs.parse(url.parse(req.url).query).changed;
  var session;
  if (id && sessions[id]) {
    session = sessions[id];
    session.poke();
  }

  var since = parseInt(qs.parse(url.parse(req.url).query).since, 10);

  channel.query(since, function (messages) {
    if (session) session.poke();
    res.simpleJSON(200, { messages: messages, rss: mem.rss });
  });
});

fu.get("/send", function (req, res) {
  var id = qs.parse(url.parse(req.url).query).id;
  var body_content = qs.parse(url.parse(req.url).query).body_content;

  var session = sessions[id];
  if (!session || !body_content) {
    res.simpleJSON(400, { error: "No such session id" });
    return;
  }

  session.poke();

  channel.append_message(session.username, "msg", body_content);
  res.simpleJSON(200, { rss: mem.rss });
});

util = {
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
};
