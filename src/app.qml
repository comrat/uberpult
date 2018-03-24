Item {
	id: main;
	anchors.fill: context;

	WebSocketServer {
		id: server;
		port: 42451;
	}

	OrientationMixin { id: orientation; }

	Timer {
		repeat: running;
		running: accelCheckbox.checked;
		interval: 100;

		onTriggered: {
			var eventString = '{"event": "accelerometer",'
			eventString += '"alpha":' + orientation.alpha + ','
			eventString += '"beta":' + orientation.beta + ','
			eventString += '"gamma":' + orientation.gamma + '}'
			server.send(eventString)
		}
	}

	Text {
		y: 10;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: server.started ? "Server started" : "Server is not started";
		color: server.started ? "#0f0" : "#f00";
		font.pixelSize: 24;
	}

	Text {
		y: 50;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: server.ip ? server.ip : "0.0.0.0";
		color: "#000";
		font.pixelSize: 24;
	}

	Text {
		y: 90;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: server.port;
		color: "#000";
		font.pixelSize: 24;
	}

	GridView {
		id: digitGrid;
		y: 130;
		width: (cellWidth + spacing) * 3;
		height: (cellHeight + spacing) * 4;
		cellWidth: 50;
		cellHeight: 50;
		anchors.horizontalCenter: parent.horizontalCenter;
		positionMode: GridView.Center;
		spacing: 5;
		model: ListModel { }
		delegate: KeyButton {
			width: parent.cellWidth;
			height: parent.cellHeight;
			key: model.key;

			onClicked: {
				var key = model.key
				log(key, "clicked")
				server.send('{ event: "keyPressed", keyCode: "' + key + '" }')
			}
		}

		onCompleted: {
			var data = [
				{ key: "1" }, { key: "2" }, { key: "3" },
				{ key: "4" }, { key: "5" }, { key: "6" },
				{ key: "7" }, { key: "8" }, { key: "9" },
				{ key: "0" }
			]
			this.model.append(data)
		}
	}

	Item {
		property int size: 50;
		property int spacing: 5;
		width: size * 3 + spacing * 2;
		anchors.top: digitGrid.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.topMargin: 30;

		KeyButton {
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/up.png";
			key: "Up";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			y: parent.size + parent.spacing;
			anchors.horizontalCenter: parent.horizontalCenter;
			text: "OK";
			key: "Select";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			y: parent.size + parent.spacing;
			icon: "res/left.png";
			key: "Left";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			x: (parent.size + parent.spacing) * 2;
			y: height + parent.spacing;
			icon: "res/right.png";
			key: "Right";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			y: (parent.size + parent.spacing) * 2;
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/down.png";
			key: "Down";

			onClicked: { this.parent.sendKey(this.key) }
		}

		sendKey(key): {
			log("dpad key pressed", key)
			server.send('{ event: "keyPressed", keyCode: "' + key + '" }')
		}
	}

	Checkbox {
		id: accelCheckbox;
		y: 560;
		anchors.horizontalCenter: parent.horizontalCenter;
	}

	Text {
		y: 610;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		font.pixelSize: 18;
		color: "#000";
		text: "Accelerometer";
	}
}
