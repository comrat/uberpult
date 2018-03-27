Object {
	id: serverProto;
	property bool started;
	property string ip;
	property string port;

	Timer {
		id: startDelayTimer;
		interval: 2000;

		onTriggered: {
			var context = this._context
			var parent = this.parent

			if (window.networkinterface)
				window.networkinterface.getIPAddress(context.wrapNativeCallback(function (ip) {
					log("Got IP", ip);
					parent.ip = ip
				}));

			if (!window.cordova || !window.cordova.plugins) {
				log("WSS Plugin wasn't initialized")
				return
			}

			var wsserver = window.cordova.plugins.wsserver;
			var port = parent.port
			wsserver.start(port, {
				'onFailure' : context.wrapNativeCallback(function(addr, port, reason) {
					log('Stopped listening on %s:%d. Reason: %s', addr, port, reason);
					parent.started = false
				}),
				'onOpen': context.wrapNativeCallback(function(user) {
					log('A user connected:', user);
					parent._user = user
				}),
				'onMessage' : context.wrapNativeCallback(function(conn, msg) {
					log(conn, msg);
				}),
				'onClose' : context.wrapNativeCallback(function(conn, code, reason, wasClean) {
					log('A user disconnected from %s', conn.remoteAddr);
				})
			}, context.wrapNativeCallback(function onStart(addr, port) {
				log('Listening on address', addr, "port", port);
				parent.started = true
			}), context.wrapNativeCallback(function onDidNotStart(reason) {
				log('Did not start. Reason: %s', reason);
				parent.started = false
			}));
			parent._wsserver = wsserver
		}
	}

	send(msg): {
		log("Send", msg, "strted", this.started, "server", this._wsserver, "user", this._user)
		if (!this.started || !this._wsserver || !this._user)
			return
		this._wsserver.send({'uuid': this._user.uuid}, msg)
	}

	onCompleted: { startDelayTimer.restart() }
}
