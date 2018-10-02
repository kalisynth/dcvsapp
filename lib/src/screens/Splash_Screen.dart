part of dcvsapp;

class SplashPage extends StatefulWidget{
  @override
  State createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{

  String _platformVersion = 'Unknown';
  Permission permission;

  void newTablet(FirebaseUser user) async{
    //Variables needed for a new tablet to be added to the firebase database
    String _uid;
    String _tabletId; //Using tablet Id instead of name initially, allowing users to change the tablet name in settings later
    DateTime _lastSeen;
    String _lastLocation;
    bool locPermission;

    String TAG = "SplashScreen";

    var currentLocation = <String, double>{};
    var location = new Location(); //Get current geo location.

    try {
      locPermission = await location.hasPermission();
      if(locPermission){
        currentLocation = await location.getLocation();
        _lastLocation = currentLocation.toString();
      } else {
        _lastLocation = 'Permission Denied';
        Utils().printError(TAG,'Permission denied');
      }
    } on PlatformException catch (e){
      if (e.code == 'PERMISSION_DENIED') {
        _lastLocation = 'Permission Denied';
        Utils().printError(TAG,'Permission denied');
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        Utils().printError(TAG,'Permission denied - please ask the user to enable it from the app settings');
        _lastLocation = 'Permission Denied';
      }

      location = null;
      currentLocation = null;
      _lastLocation = "Error";
    }

    _uid = user.uid; //Anon UserId
    _tabletId = await DCVSDevice().getDeviceName();
    _lastSeen = DateTime.now();

    await DCVSSyncs().setSharedString('tabletName', _tabletId);

    Utils().printInfo(TAG, "New Device info: $_uid , $_tabletId , $_lastSeen , $_lastLocation");

    DeviceStore tabletStorage = new DeviceStore.forUser(user: user);
    tabletStorage.createDevice(_tabletId, _uid, _lastSeen, _lastLocation);

    UserStore userStore = new UserStore.forUser(user: user);
    userStore.createUser(_uid, _tabletId);

    Navigator.of(context).pushReplacementNamed(navLinks.linkMainScreen);
  }

  requestPermission() async{
    Permission locationPermission = Permission.AccessFineLocation;
    final res = await SimplePermissions.requestPermission(locationPermission);
    print("permission request result is " + res.toString());
  }

  void updateTablet(FirebaseUser user) async{
    DeviceStore deviceStorage = new DeviceStore.forUser(user: user);

    String _tabletId;
    _tabletId = await DCVSDevice().getDeviceName();

    DeviceItem updateDevice = await deviceStorage.getDevice(_tabletId);

    DateTime _updateDate = DateTime.now();
    String _newLocation;
    bool locPermission;

    var currentLocation = <String, double>{};
    var location = new Location(); //Get current geo location.

    try {
      locPermission = await location.hasPermission();
      if(locPermission){
        currentLocation = await location.getLocation();
        _newLocation = currentLocation.toString();
      } else {
        await requestPermission();
        try{
          locPermission = await location.hasPermission();
          if(locPermission){
            currentLocation = await location.getLocation();
            _newLocation = currentLocation.toString();
          } else {
            _newLocation = 'Permission Denied';
            Utils().printError('SplashScreen','Permission denied');
          }
        } on PlatformException catch (e){
          if (e.code == 'PERMISSION_DENIED') {
            _newLocation = 'Permission Denied';
            Utils().printError('SplashScreen','Permission denied');
          } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
            Utils().printError('SplashScreen','Permission denied - please ask the user to enable it from the app settings');
            _newLocation = 'Permission Denied';
          }
          location = null;
          currentLocation = null;
          _newLocation = "Error";
        }
      }
    } on PlatformException catch (e){
      if (e.code == 'PERMISSION_DENIED') {
        _newLocation = 'Permission Denied';
        Utils().printError('SplashScreen','Permission denied');
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        Utils().printError('SplashScreen','Permission denied - please ask the user to enable it from the app settings');
        _newLocation = 'Permission Denied';
      }

      location = null;
      currentLocation = null;
      _newLocation = "Error";
    }

    updateDevice.lastSeen = _updateDate.toUtc().toIso8601String();
    updateDevice.lastLocation = _newLocation;

    deviceStorage.updateDevice(updateDevice);
    Navigator.of(context).pushReplacementNamed(navLinks.linkMainScreen);
  }

  void tabletCheck(FirebaseUser user) async{
    DeviceStore tabletStorage = new DeviceStore.forUser(user: user);

    String _tabletId;
    _tabletId = await DCVSDevice().getDeviceName();

    bool _deviceCheck = await tabletStorage.deviceCheck(_tabletId);

    if(_deviceCheck){
      updateTablet(user);
    } else {
      newTablet(user);
    } //check if user already has a device added
  }

  @override
  void initState(){
    super.initState();

    initPlatformState();

    _auth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
      tabletCheck(user);
    });

    // Give the navigation animations, etc, some time to finish
    new Future.delayed(new Duration(seconds: 1))
        .then((_) => signInAnon());
  }

  initPlatformState() async{
    String platformVersion;

    try{
      platformVersion = await SimplePermissions.platformVersion;
    } on PlatformException{
      platformVersion = 'Failed to get platform version';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new LoadingIndicator();
  }
}