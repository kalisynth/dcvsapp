part of dcvsapp;

class WebScreen extends StatefulWidget{
  @override
  State createState() => new WebState();
}

class WebState extends State<WebScreen>{
  double buttonHeight;
  double buttonMinWidth;

  Color bgColor = DefaultSettings().webBGColor;
  Color fntColor = DefaultSettings().webFontColor;

  String tag = "WEBSCREEN";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Options"),
        backgroundColor: bgColor,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: fntColor,
        ),
      ),
      backgroundColor: bgColor,
      body: new Container(
          child: new Column(
              children: <Widget>[
                new Text('Web View Goes Here'),
              ]
          )
      ),
    );
  }
}