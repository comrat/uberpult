var express = require("express");
var app = express();
app.use(express.static(__dirname + "/public"));

var state = { alpha: 0, beta: 0, gamma: 0 };

app.get("/api/state", function(req, res) {
	res.send(state);
});

app.listen(3000, function() {
	console.log("Server started...");
});


const cordova = require('cordova-bridge');

cordova.channel.on('message', function (msg) {
  console.log('[node] received:', msg);
  cordova.channel.send('Replying to this message: ' + msg);
});
