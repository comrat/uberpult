Rectangle {
	id: joyStickProto;
	signal moved;
	property bool moveToInitialState: true;
	width: 120;
	height: 120;
	radius: width / 2;
	color: "#000";

	Rectangle {
		x: 10;
		y: 10;
		width: 100;
		height: 100;
		radius: width / 2;
		color: "#424242";

		DragMixin {
			top: -10;
			left: -10;
			right: 30;
			bottom: 30;

			onPressedChanged: {
				if (!value) {
					log("Trigger released")
					triggerDelay.restart()
				} else {
					joyStickProto.moveToInitialState = false
				}
			}
		}

		Timer {
			id: triggerDelay;
			interval: 500;

			onTriggered: {
				joyStickProto.moveToInitialState = true
				this.parent.x = 10
				this.parent.y = 10
			}
		}

		Timer {
			interval: 50;
			running: !joyStickProto.moveToInitialState;
			repeat: running;

			onTriggered: {
				var x = (this.parent.x - 10) / 20
				var y = -(this.parent.y - 10) / 20
				joyStickProto.moved(x, y)
			}
		}
	}
}
