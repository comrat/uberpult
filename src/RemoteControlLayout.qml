ControlLayout {
	id: remoteControlLayoutProto;

	Text {
		y: 10;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: parent.serverStarted ? "Server started" : "Server is not started";
		color: parent.serverStarted ? "#0f0" : "#f00";
		font.pixelSize: 24;
	}

	Text {
		y: 50;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: parent.serverIp ? parent.serverIp : "0.0.0.0";
		color: "#000";
		font.pixelSize: 24;
	}

	Text {
		y: 90;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: parent.serverPort;
		color: "#000";
		font.pixelSize: 24;
	}

	DigitGrid {
		id: digitGrid;
		y: 130;

		onSendKey(key): {
			log("Digit key pressed", key)
			remoteControlLayoutProto.send('{ "event": "keyPressed", "keyCode": "' + key + '" }')
		}
	}

	DPad {
		anchors.top: digitGrid.bottom;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.topMargin: 30;

		onSendKey(key): {
			log("dpad key pressed", key)
			remoteControlLayoutProto.send('{ "event": "keyPressed", "keyCode": "' + key + '" }')
		}
	}

	Checkbox {
		id: accelCheckbox;
		y: 560;
		anchors.horizontalCenter: parent.horizontalCenter;
		touchEnabled: parent.serverStarted;
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
