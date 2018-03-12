Item {
	id: main;
	property bool started;
	property int alpha;
	property int beta;
	property int gamma;
	property string ip;
	anchors.fill: context;

	Text {
		x: 10;
		y: 10;
		text: parent.started ? "Server started" : "Server is not started";
		color: parent.started ? "#0f0" : "#f00";
		font.pixelSize: 24;
	}

	Text {
		x: 10;
		y: 50;
		text: parent.ip;
		color: "#000";
		font.pixelSize: 24;
	}

	Text {
		x: 10;
		y: 100;
		width: 100;
		text: "alpha: " + main.alpha + "<br>beta: " + main.beta + "<br>gamma: " + main.gamma;
		color: "#000";
	}

	OrientationMixin {
		id: orientMixin;

		onBetaChanged,
		onAlphaChanged,
		onGammaChanged,
		onAbsoluteChanged: {
			main.alpha = Math.round(this.alpha)
			main.beta = Math.round(this.beta)
			main.gamma = Math.round(this.gamma)
		}
	}

	Timer {
		id: startDelayTimer;
		interval: 3000;

		onTriggered: {
			var context = this._context
			var parent = this.parent

			window.networkinterface.getIPAddress(function (ip) {
				log("Got IP", ip);
				parent.ip = ip
				context._processActions()
			});

			log("Wind", window)
			var wsserver = window.cordova.plugins.wsserver;

			var port = 41574
			wsserver.start(port, {
				'onFailure' :  function(addr, port, reason) {
					log('Stopped listening on %s:%d. Reason: %s', addr, port, reason);
					parent.started = false
				},
				'onOpen' : function(conn) {
					log('A user connected from %s', conn.remoteAddr, "conn", conn);
				},
				'onMessage' : function(conn, msg) {
					log(conn, msg);
				},
				'onClose' : function(conn, code, reason, wasClean) {
					log('A user disconnected from %s', conn.remoteAddr);
				}
			}, function onStart(addr, port) {
				log('Listening on address', addr, "port", port);
				parent.started = true
				context._processActions()
			}, function onDidNotStart(reason) {
				log('Did not start. Reason: %s', reason);
				parent.started = false
			});

			// wsserver.send({'uuid':conn.uuid}, "LOL");
		}
	}

	Timer {
		id: pollingDelayTimer;
		interval: 1000;

		onTriggered: {
			var parent = this.parent
			window.nodejs.channel.send({ alpha: parent.alpha, beta: parent.beta, gamma: parent.gamma });
		}
	}

	onBetaChanged,
	onAlphaChanged,
	onGammaChanged: {
		// pollingDelayTimer.restart()
	}

	onCompleted: { startDelayTimer.restart() }
}
