var express = require("express");
var app = express();

app.use(function(req, res, next) {
	res.header("Access-Control-Allow-Origin", "*");
	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
	next();
});

var state = { alpha: 0, beta: 0, gamma: 0 };

app.get("/api/state", function(req, res) {
	res.send(state);
});

app.listen(3000, function() {
	console.log("Server started...");
});


const cordova = require('cordova-bridge');

cordova.channel.on('message', function (newState) {
  console.log('[node] received:', newState);
  state = newState;
});
