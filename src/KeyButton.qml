WebItem {
	property string key;
	property string icon;
	property string text;
	width: 50;
	height: 50;
	color: "#424242";

	Text {
		width: 100%;
		height: 100%;
		verticalAlignment: Text.AlignVCenter;
		horizontalAlignment: Text.AlignHCenter;
		font.pixelSize: 24;
		color: "#fff";
		text: parent.text ? parent.text : parent.key;
		visible: !parent.icon;
	}

	ImageMixin { width: 100%; height: 100%; source: parent.icon; }
}

