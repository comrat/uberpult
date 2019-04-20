# Uberpult
[PureQML](https://github.com/pureqml/qmlcore) based special RCU android application which works via WebSocket server (thanks [cordova-plugin-websocket-server](https://github.com/becvert/cordova-plugin-websocket-server)). You can interact with your PureQML application with this app.

# Installation
To build and install the app on your android device you need to install:
* [cordova](https://cordova.apache.org/docs/en/latest/guide/cli/#installing-the-cordova-cli)
* [adb](http://bernaerts.dyndns.org/linux/74-ubuntu/354-ubuntu-xenial-android-adb-fastboot-qtadb)
* [python](https://www.python.org/downloads/) with [jinja2](http://jinja.pocoo.org/docs/2.10/intro/) templater

After repository cloning you need to update submodules:
```
git submodule init

git submodule update
```

Then connect to your phone [via adb](https://developer.android.com/studio/command-line/adb). Run this command after that:

`./smart-tv-deployer/smart-tv-deployer.py -p android`

If everything is fine you will see <i>uberpult</i> application on your android device.

This script was tested only on linux.
