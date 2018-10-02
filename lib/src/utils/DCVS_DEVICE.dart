part of dcvsapp;

class DCVSDevice{

  static final dTAG = "DCVSDEVICE";

  Future<String> getDeviceName() async{
    String deviceName;

    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

    try {
      if(Platform.isAndroid){
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
      } else if(Platform.isIOS){
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
      }
    } on PlatformException {
      Utils().printError(dTAG, 'Failed to get platform version');
    }

    return deviceName;
  }

}

class TabletNameStatus{
  String defaultName = "Not Set";
  String tabletName = "";
  String _tabletName = "";

  void getTabletName() async{
    _tabletName = await dcvsSyncs.getSharedString('tabletName');
    if(_tabletName == null || _tabletName.isEmpty){
      tabletName = defaultName;
    } else {
      tabletName = _tabletName;
    }
  }

  void changeTabletName(String newName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tabletName', newName);
  }

}