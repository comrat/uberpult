Item {
	anchors.fill: context;

	Rectangle {
		width: 100;
		height: 70;
		anchors.centerIn: parent;
		color: "green";

		ClickMixin { }

		onClicked: {
			var nodejs = window.nodejs
			nodejs.channel.setListener(function(msg) { log('[cordova] received:' + msg); });
			nodejs.start('main.js',
				function(err) {
					var nodejs = window.nodejs
					log("startupCallback", err)
					if (err) {
						log(err);
					} else {
						log ('Node.js Mobile Engine Started');
						nodejs.channel.send('Hello from Cordova!');
					}
				}
			)
		}
	}
}
