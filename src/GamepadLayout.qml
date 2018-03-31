ControlLayout {

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
			key: "Triangle";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			y: parent.size + parent.spacing;
			icon: "res/square.png";
			key: "Square";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			x: (parent.size + parent.spacing) * 2;
			y: height + parent.spacing;
			icon: "res/circle.png";
			key: "Circle";

			onClicked: { this.parent.sendKey(this.key) }
		}

		KeyButton {
			y: (parent.size + parent.spacing) * 2;
			anchors.horizontalCenter: parent.horizontalCenter;
			icon: "res/cross.png";
			key: "Cross";

			onClicked: { this.parent.sendKey(this.key) }
		}
	}

	JoyStick {
		anchors.top: navigationKeys.bottom;
		anchors.left: navigationKeys.right;
	}

	JoyStick {
		anchors.top: actionKeys.bottom;
		anchors.right: actionKeys.left;
	}
}
