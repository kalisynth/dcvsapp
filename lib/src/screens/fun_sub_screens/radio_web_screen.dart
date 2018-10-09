part of dcvsapp;

class RadioScreen extends StatefulWidget{
  @override
  State createState() => new RadioState();
}

class RadioState extends State<RadioScreen>{
  double buttonHeight;
  double buttonMinWidth;
  String tabletName;

  String tag = "RADIOSCREEN";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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

  void playRadio(){

  }

  void changeStation(){

  }

  @override
  Widget build(BuildContext context){

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Radio"),
        backgroundColor: Colors.redAccent,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black
        ),
      ),
      backgroundColor: Colors.redAccent,
      body: new Container(
          child: new Column(
              children: <Widget>[
                new Text('Radio goes Here'),
                new FlatButton(
                  child: new Text("PLAY"),
                  onPressed:(){
                    playRadio();
                  }
                ),
                new FlatButton(
                    child: new Text("Change Station"),
                    onPressed:(){
                      changeStation();
                    }
                ),
              ]
          )
      ),
    );
  }
}