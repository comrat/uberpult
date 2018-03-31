Item {
	signal sendKey;
	property int size: 50;
	property int spacing: 5;
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
}
