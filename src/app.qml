Item {
	id: main;
	anchors.fill: context;

	WebSocketServer {
		id: server;
		port: 42451;
	}

	Accelerometer {
		enabled: accelCheckbox.checked;

		onSendPosition(alpha, beta, gamma): {
			var eventString = '{"event": "accelerometer",'
			eventString += '"alpha":' + alpha + ','
			eventString += '"beta":' + beta + ','
			eventString += '"gamma":' + gamma + '}'
			server.send(eventString)
		}
	}

	PageStack {
		width: 100%;
		height: 100%;
		currentIndex: context.system.landscape ? 1 : 0;

		RemoteControlLayout {
			serverIp: server.ip;
			serverPort: server.port;
			serverStarted: server.started;

			onSend(data): { server.send(data) }
		}

		Item {
		//TODO: imple landscape layout (gamepad mode)
		}
	}
}
