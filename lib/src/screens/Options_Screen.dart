part of dcvsapp;

class OptionsScreen extends StatefulWidget{
  @override
  State createState() => new OptionsState();
}

class OptionsState extends State<OptionsScreen>{
  double buttonHeight;
  double buttonMinWidth;
  String tabletName;

  String tag = "OPTIONS";
  final _optionsColor = DefaultSettings().optionsColor;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [
    {
      "app_name": "Skype",
      "package_name": "calshow://"
    },
  ];


  void uiSetup() async{
    buttonHeight = await dcvsSyncs.getSharedDouble(dcvsKeys.keyButtonHeight);
    buttonMinWidth = await dcvsSyncs.getSharedDouble(dcvsKeys.keyButtonWidth);
    if(buttonHeight == null){
      buttonHeight = 50.0;
    }

    if(buttonMinWidth = null){
      buttonMinWidth = 100.0;
    }
  }

  Future<Null> setCurrentTabletName() async{
    String _tabletName = await dcvsSyncs.getSharedString('tabletName');
    if(_tabletName.isEmpty || _tabletName == null){
      _tabletName = " ";
    }
    setState((){
      tabletName = _tabletName;
    });
  }

  @override
  void initState() {
    uiSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    void setSwipe() async{
      bool swipeEnabled = await dcvsSyncs.getSharedBool(dcvsKeys.keySwipeToNav);
      Utils().printInfo(tag, "Swipe $swipeEnabled");
      bool swipeSet;

      if(swipeEnabled == null){
        swipeEnabled = true;
      }

      if(swipeEnabled){
        swipeSet = await dcvsSyncs.setSharedBool(dcvsKeys.keySwipeToNav, false);
      } else {
        swipeSet = await dcvsSyncs.setSharedBool(dcvsKeys.keySwipeToNav, true);
      }

      if(swipeSet){
        showInSnackBar(_scaffoldKey, "Swipe Options Set");
      }
    }

    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: _optionsColor,
      body: new Column(
              children: <Widget>[
                new Text('Tablet Name is $tabletName'),
                new MaterialButton(
                  height: buttonHeight,
                  minWidth: buttonMinWidth,
                  color: Colors.black,
                  splashColor: Colors.amber,
                  textColor: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      new Text("Set Swipe to Navigate"),
                    ],
                  ),
                  onPressed:() => setSwipe(),
                ),
              ]
          )
    );
  }

  void saveTabletName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tabletName', tabletName);
    print('set tabletName to ${prefs.getString('tabletName')}');
  }

  void _handleNameSubmit(){
    final FormState form = _formKey.currentState;

    if(!form.validate()){
      Utils().printError(tag, "Form not validated");
      showInSnackBar(_scaffoldKey, "Fix Errors in Submission");
    } else {
      Utils().printInfo(tag, "form Validated");
      form.save();
    }
  }

  Future<Null> saveNewTabletName() async{
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text("Name of Tablet"),
          content: new SingleChildScrollView(
            child: new Form(
              key: _formKey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'Enter Tablet Name:',
                      labelText: 'Name:',
                    ),
                    onSaved:(String value){
                      print("Get $value");
                      tabletName = value;
                    }
                  ),
                  new FlatButton(
                    child: new Row(
                      children: <Widget>[
                        new Text('Save'),
                        new Icon(Icons.save)
                      ],
                    ),
                    onPressed:(){
                      _handleNameSubmit();
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
}