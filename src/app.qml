Item {
	property bool started;
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
						nodejs.channel.send('Hello from Cordova!');
					}
				}
			)

			window.networkinterface.getIPAddress(function (ip) {
				log("Got IP", ip);
				parent.ip = ip
			});
		}
	}

	onCompleted: { startDelayTimer.restart() }
}
