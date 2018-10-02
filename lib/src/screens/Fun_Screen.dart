part of dcvsapp;

class FunScreen extends StatefulWidget{
  @override
  State createState() => new FunState();
}

class FunState extends State<FunScreen>{
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
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Fun"),
        backgroundColor: Colors.amberAccent,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black
        ),
      ),
      backgroundColor: Colors.amberAccent,
      body: new Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/backgrounds/fun_bg.png")
              )
          ),
          child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                ),
                new MaterialButton(
                  height: buttonHeight,
                  minWidth: buttonMinWidth,
                  color: Colors.green,
                  splashColor: Colors.amber,
                  textColor: Colors.black,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.games),
                      new Text("Games"),
                    ],
                  ),
                  onPressed:() => null,
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                ),
                new MaterialButton(
                  height: buttonHeight,
                  minWidth: buttonMinWidth,
                  color: Colors.blueGrey,
                  splashColor: Colors.amber,
                  textColor: Colors.black,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.web),
                      new Text("Web"),
                    ],
                  ),
                  onPressed:() => null,
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                ),
                new MaterialButton(
                  height: buttonHeight,
                  minWidth: buttonMinWidth,
                  color: Colors.yellow,
                  splashColor: Colors.amber,
                  textColor: Colors.black,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.radio),
                      new Text("Radio"),
                    ],
                  ),
                  onPressed:() => null,
                ),
              ]
          )
      ),
    );
  }
}