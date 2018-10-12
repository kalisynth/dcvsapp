part of dcvsapp;

class GamesScreen extends StatefulWidget{
  @override
  State createState() => new GamesState();
}

class GameData{
  String name;
  String uri;
}

class GamesState extends State<GamesScreen>{
  double buttonHeight;
  double buttonMinWidth;

  String TAG = "GAMESSCREEN";
  bool isAndroid;

  GameData gameData;

  FirebaseUser user;

  GameStore gameStore;

  Color bgColor = DefaultSettings().gamesBGColor;
  Color fntColor = DefaultSettings().gamesFontColor;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _autoValidate = false;

  List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [
    {
      "app_name": "Skype",
      "package_name": "calshow://"
    },
  ];

  void uiSetup() async{
    buttonHeight = await dcvsSyncs.getSharedDouble(dcvsKeys.key_buttonheight);
    buttonMinWidth = await dcvsSyncs.getSharedDouble(dcvsKeys.key_buttonWidth);
    if(buttonHeight == null){
      buttonHeight = 50.0;
    }

    if(buttonMinWidth = null){
      buttonMinWidth = 100.0;
    }
  }

  @override
  void initState() {
    uiSetup();
    super.initState();

    isAndroid = Platform.isAndroid;

    _auth.currentUser().then((FirebaseUser user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        setState(() {
          this.user = user;
        });
      }
    });
  }

  void saveGame(){
    final FormState form = _formKey.currentState;
    form.save();

    gameStore = new GameStore.forUser(user: user);

    String _gameName = gameData.name;
    String _gameUri = gameData.uri;

    try{
      gameStore.createGame(_gameName, _gameUri);
    } catch(e){
      print("[%$TAG : ERROR] - Insert Game Exception $e");
    }
  }

  void addGame(BuildContext context){
    gameData = new GameData();
    showAddGamePopup(context);
  }

  Future<Null> showAddGamePopup(BuildContext context) async{
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text("Add Game"),
          content: new SingleChildScrollView(
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new Column(
                children:<Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'Game Name',
                      labelText: 'Name:'
                    ),
                    onSaved: (String value){
                      gameData.name = value;
                    }
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'Game Uri',
                      labelText: 'Uri:',
                    ),
                    onSaved: (String value){
                      gameData.uri = value;
                    }
                  ),
                  new FlatButton(
                    child: new Text('Save'),
                    onPressed:(){
                      saveGame();
                      Navigator.of(context).pop();
                    }
                  )
                ]
              )
            )
          )
        );
      }
    );
  }

  Future<void> getApps() async{
    List<Map<String, String>> _installedApps;

    if(isAndroid){
      _installedApps = await AppAvailability.getInstalledApps();


    }
  }

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Games"),
        backgroundColor: bgColor,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: fntColor,
        ),
      ),
      backgroundColor: bgColor,
      body: new Container(
          child: new Column(
              children: <Widget>[
                new Text('List of Games'),
                new FlatButton(
                  child: new Text("Add Game"),
                  onPressed: () => addGame(context),
                ),
                new FlatButton(
                  child: new Text("Get List of Apps"),
                  onPressed: isAndroid ? getApps : null,
                )
              ]
          )
      ),
    );
  }
}