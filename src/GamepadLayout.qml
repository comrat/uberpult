ControlLayout {
	id: gamepadLayoutProto;

	Text {
		y: 30;
		width: 100%;
		horizontalAlignment: Text.AlignHCenter;
		text: parent.serverIp ? parent.serverIp : "0.0.0.0";
		color: "#000";
		font.pixelSize: 24;
	}

	Item {
		id: navigationKeys;
		property int size: 50;
		property int spacing: 5;
		x: 30;
		y: 30;
		width: size * 3 + spacing * 2;
		height: width;

		KeyButton {
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/up.png";
			key: "Up";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}

		KeyButton {
			y: parent.size + parent.spacing;
			icon: "res/left.png";
			key: "Left";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}

		KeyButton {
			x: (parent.size + parent.spacing) * 2;
			y: height + parent.spacing;
			icon: "res/right.png";
			key: "Right";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}

		KeyButton {
			y: (parent.size + parent.spacing) * 2;
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/down.png";
			key: "Down";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}
	}

	Item {
		id: actionKeys;
		property int size: 50;
		property int spacing: 5;
		y: 30;
		width: size * 3 + spacing * 2;
		height: width;
		anchors.right: parent.right;
		anchors.rightMargin: 30;

		KeyButton {
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/triangle.png";
			key: "Green";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}

		KeyButton {
			y: parent.size + parent.spacing;
			icon: "res/square.png";
			key: "Yellow";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}

		KeyButton {
			x: (parent.size + parent.spacing) * 2;
			y: height + parent.spacing;
			icon: "res/circle.png";
			key: "Red";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}

		KeyButton {
			y: (parent.size + parent.spacing) * 2;
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/cross.png";
			key: "Blue";

			onClicked: { gamepadLayoutProto.sendKey(this.key) }
		}
	}

	JoyStick {
		anchors.top: navigationKeys.bottom;
		anchors.left: navigationKeys.right;

		onMoved(x, y): { gamepadLayoutProto.send('{ "event": "leftJoystick", "axes": { "x": ' + x + ', "y": ' + y + ' } }') }
	}

	JoyStick {
		anchors.top: actionKeys.bottom;
		anchors.right: actionKeys.left;

		onMoved(x, y): { gamepadLayoutProto.send('{ "event": "rightJoystick", "axes": { "x": ' + x + ', "y": ' + y + ' } }') }
	}

	sendKey(key): { this.send('{ "event": "keyPressed", "key": "' + key + '" }') }
}
