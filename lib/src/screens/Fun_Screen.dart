part of dcvsapp;

class FunScreen extends StatefulWidget{
  @override
  State createState() => new FunState();
}

class FunState extends State<FunScreen>{
  double buttonHeight;
  double buttonMinWidth;

  final _funColor = DefaultSettings().funColor;

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
    return new Scaffold(
        backgroundColor: _funColor,
      body: new Container(
          width: double.infinity,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/backgrounds/fun_bg.png"),
          ),
        ),
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                    child: new Text("Games"),
                    onPressed:(){
                      Navigator.of(context).pushNamed(navLinks.linkGamesScreen);
                    }
                ),
                new FlatButton(
                    child: new Text("Radio"),
                    onPressed:(){
                      Navigator.of(context).pushNamed(navLinks.linkRadioScreen);
                    }
                ),
                new FlatButton(
                    child: new Text("Web"),
                    onPressed:(){
                      Navigator.of(context).pushNamed(navLinks.linkWebScreen);
                    }
                ),
              ]
          )
      )
    );
  }
}