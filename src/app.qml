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
			var nodejs = window.nodejs
			var parent = this.parent
			nodejs.channel.setListener(function(msg) { log('[cordova] received:' + msg); });
			nodejs.start('main.js',
				function(err) {
					var nodejs = window.nodejs
					if (err) {
						log("startupCallback error:", err)
						parent.started = false
					} else {
						log('Node.js Mobile Engine Started');
						parent.started = true
					}
				}
			)

			window.networkinterface.getIPAddress(function (ip) {
				log("Got IP", ip);
				parent.ip = ip
			});
		}
	}

	Timer {
		id: pollingDelayTimer;
		interval: 100;

		onTriggered: {
			var parent = this.parent
			window.nodejs.channel.send({ alpha: parent.alpha, beta: parent.beta, gamma: parent.gamma });
		}
	}

	onBetaChanged,
	onAlphaChanged,
	onGammaChanged: {
		pollingDelayTimer.restart()
	}

	onCompleted: { startDelayTimer.restart() }
}
