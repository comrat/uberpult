GridView {
	id: digitGridProto;
	signal sendKey;
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

		onClicked: { digitGridProto.sendKey(model.key) }
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
