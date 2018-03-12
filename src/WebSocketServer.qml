Object {
	id: serverProto;
	property bool started;
	property string ip;

	Timer {
		id: startDelayTimer;
		interval: 2000;

		onTriggered: {
			var context = this._context
			var parent = this.parent

			window.networkinterface.getIPAddress(function (ip) {
				log("Got IP", ip);
				parent.ip = ip
				context._processActions()
			});

			var wsserver = window.cordova.plugins.wsserver;
			var self = this
			var port = 41574
			wsserver.start(port, {
				'onFailure' :  function(addr, port, reason) {
					log('Stopped listening on %s:%d. Reason: %s', addr, port, reason);
					parent.started = false
					context._processActions()
				},
				'onOpen': function(user) {
					log('A user connected:', user);
					self._user = user
					context._processActions()
				},
				'onMessage' : function(conn, msg) {
					log(conn, msg);
				},
				'onClose' : function(conn, code, reason, wasClean) {
					log('A user disconnected from %s', conn.remoteAddr);
				}
			}, function onStart(addr, port) {
				log('Listening on address', addr, "port", port);
				parent.started = true
				context._processActions()
			}, function onDidNotStart(reason) {
				log('Did not start. Reason: %s', reason);
				parent.started = false
			});
			this._wsserver = wsserver
			// wsserver.send({'uuid':conn.uuid}, "LOL");
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
