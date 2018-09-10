part of dcvsapp;

class OptionsScreen extends StatefulWidget{
  @override
  State createState() => new OptionsState();
}

class OptionsState extends State<OptionsScreen>{
  double buttonHeight;
  double buttonMinWidth;

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

  @override
  Widget build(BuildContext context){
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    void setSwipe() async{
      bool swipeEnabled = await dcvsSyncs.getSharedBool(dcvsKeys.key_swipeToNav);
      print("swipeEnabled: $swipeEnabled");
      bool swipeSet;

      if(swipeEnabled == null){
        swipeEnabled = true;
      }

      if(swipeEnabled){
        swipeSet = await dcvsSyncs.setSharedBool(dcvsKeys.key_swipeToNav, false);
      } else {
        swipeSet = await dcvsSyncs.setSharedBool(dcvsKeys.key_swipeToNav, true);
      }

      if(swipeSet){
        showInSnackBar(_scaffoldKey, "Swipe Options Set");
      }
    }

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Options"),
      ),
      backgroundColor: Colors.redAccent,
      body: new Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/backgrounds/options_bg.png")
              )
          ),
          child: new Column(
              children: <Widget>[
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
      ),
    );
  }
}