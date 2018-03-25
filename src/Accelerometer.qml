Object {
	signal sendPosition;
	property bool enabled;

	OrientationMixin { id: orientation; }

	Timer {
		repeat: running;
		running: parent.enabled;
		interval: 100;

		onTriggered: { this.parent.sendPosition(orientation.alpha, orientation.beta, orientation.gamma) }
	}
}
