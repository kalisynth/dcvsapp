part of dcvsapp;

class GamesScreen extends StatefulWidget{
  @override
  State createState() => new GamesState();
}

class GamesState extends State<GamesScreen>{
  double buttonHeight;
  double buttonMinWidth;

  String tag = "GAMESSCREEN";

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
  }

  void addGame(){

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

                    )
                  )
                ]
              )
            )
          )
        )
      }
    )
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
                  onPressed: () => addGame(),
                )
              ]
          )
      ),
    );
  }
}