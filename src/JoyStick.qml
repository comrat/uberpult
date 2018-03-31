Rectangle {
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
		}
	}
}
