Item {
	id: main;
	property int alpha;
	property int beta;
	property int gamma;
	anchors.fill: context;

	Text {
		x: 10;
		y: 10;
		text: server.started ? "Server started" : "Server is not started";
		color: server.started ? "#0f0" : "#f00";
		font.pixelSize: 24;
	}

	Text {
		x: 10;
		y: 50;
		text: server.ip;
		color: "#000";
		font.pixelSize: 24;
	}

	WebSocketServer { id: server; }
}
