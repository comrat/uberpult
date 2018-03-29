Item {
	width: 100%;
	height: 100%;

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

	DigitGrid {
		id: digitGrid;
		y: 130;

		onSendKey(key): {
			log("Digit key pressed", key)
			server.send('{ event: "keyPressed", keyCode: "' + key + '" }')
		}
	}

	DPad {
		anchors.top: digitGrid.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.topMargin: 30;

		onSendKey(key): {
			log("dpad key pressed", key)
			server.send('{ event: "keyPressed", keyCode: "' + key + '" }')
		}
	}

	Checkbox {
		id: accelCheckbox;
		y: 560;
		anchors.horizontalCenter: parent.horizontalCenter;
		touchEnabled: server.started;
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
