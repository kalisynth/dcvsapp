part of dcvsapp;

class ChatScreen extends StatefulWidget{
  @override
  State createState() => new ChatState();
}

class AddContactData{
  String contactName;
  String contactSkypeName;
}

AddContactData acd = new AddContactData();

class ChatState extends State<ChatScreen>{
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;
  static const platform = const MethodChannel('au.org.nac.io/skypeCalls');
  double buttonHeight;
  double buttonMinWidth;
  String TAG = "CHATSCREEN";

  ContactProvider contactProvider;



  Future<Null> showAddContactDialog(BuildContext context) async{
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return new AlertDialog(
          title: new Text("Add Contact"),
          content: new SingleChildScrollView(
            child: new Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'John Smith',
                      labelText: 'Name:',
                    ),
                    onSaved: (String value){
                      acd.contactName = value;
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'johnsmith2934',
                      labelText: 'Skype Name:',
                    ),
                    onSaved: (String value){
                      acd.contactSkypeName = value;
                    },
                  ),
                  new FlatButton(
                    child: new Text("Add"),
                    onPressed:(){
                      _handleNameSubmitted();
                      Navigator.of(context).pop();
                    }
                  )
                ]
              ),
            )
          ),
        );
      }
    );
  }

  void _handleNameSubmitted(){
    final FormState form = _formKey.currentState;
    form.save();
    saveContact();
  }

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

  void openSkypeTest(){
    try{
      platform.invokeMethod('openSkype');
    } on PlatformException catch (e){
      print("failed to open skype $e");
    }
  }

  void openDb() async{
    //String path = await initDeleteDb("dcvs.db");
  }

  @override
  void initState() {
    uiSetup();
    contactProvider = new ContactProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Chat"),
      ),
      backgroundColor: Colors.green,
      body: new Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/backgrounds/chat_bg.png")
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
                  color: Colors.blue,
                  splashColor: Colors.greenAccent,
                  textColor: Colors.black,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.add),
                      new Text("Add Contact"),
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
                  color: Colors.lightBlueAccent,
                  splashColor: Colors.greenAccent,
                  textColor: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.chat_bubble_outline),
                      new Text("Open Skype"),
                    ],
                  ),
                  onPressed:() => openSkypeTest(),
                ),
              ]
          )
      ),
    );
  }

  void saveContact() async{
    Contact newContact = new Contact();
    newContact.name = acd.contactName;
    newContact.skypeName = acd.contactSkypeName;

    try{
      contactProvider.insertContact(newContact);
    } catch(e){
      print("[$TAG : ERROR] - Insert Contact Exception : $e");
    }
  }
}