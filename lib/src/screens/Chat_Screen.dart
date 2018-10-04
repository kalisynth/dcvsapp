part of dcvsapp;

class ChatScreen extends StatefulWidget{
  @override
  State createState() => new ChatState();
}

enum TypeFilter{
  ALL,
  SERVICE,
  NONSERVICE,
}

class AddContactData{
  String contactName;
  String contactSkypeName;
  String serviceProviderName;
  bool serviceProvider;
}

AddContactData acd = new AddContactData();

class ChatState extends State<ChatScreen>{
  TypeFilter typeFilter;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;
  static const platform = const MethodChannel('au.org.nac.io/skypeCalls');
  double buttonHeight;
  double buttonMinWidth;
  String TAG = "CHATSCREEN";
  FirebaseUser user;
  bool checkValue = false;

  ContactProvider contactProvider;

  ContactStore contactStore;
  StreamSubscription<QuerySnapshot> contactSub;

  List<SkypeItem> contacts;

  Set<String> disabledContacts;

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
                  new Row(
                    children:<Widget>[
                      new Text("Service Provider?"),
                      new Checkbox(
                        value: checkValue,
                        onChanged: (bool newValue){
                          checkValue = newValue;
                        },
                      )
                    ]
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: 'dcvs',
                      labelText: 'Service Provider Name:',
                    ),
                    onSaved: (String value){
                      acd.serviceProviderName = value;
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
    acd.serviceProvider = checkValue;
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
    AppAvailability.launchApp('com.skype.raider');
  }

  void testSkypeCall() async{
    String contact = "coconutdcvs";
    var url = "skype:$contact?call&video=true";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //dcvsUtils.
      throw 'Could not launch $url';
    }
  }

  void openDb() async{
    //String path = await initDeleteDb("dcvs.db");
  }

  @override
  void initState() {
    uiSetup();
    super.initState();

    contacts = [];

    disabledContacts = new Set();

    _auth.currentUser().then((FirebaseUser user){
      if(user == null){
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        contactStore = new ContactStore.forUser(user: user);
        contactSub?.cancel();
        contactSub = contactStore.skypeList().listen((QuerySnapshot snapshot){
          final List<SkypeItem> contacts = snapshot.documents.map(ContactStore.fromDocument).toList(growable: false);
          setState((){
            this.contacts = contacts;
          });
        });

        setState((){
          this.user = user;
        });
      }
    });
  }

  @override
  void dispose(){
    contactSub?.cancel();
    super.dispose();
  }

  void setFilter(TypeFilter filter){
    setState((){
      typeFilter = filter;
    });
  }

  Widget buildToggleButton(TypeFilter type, String text){
    final bool enabled = type == typeFilter;

    Widget button = new MaterialButton(
      key: new Key('filter-button-${text.toLowerCase()}'),
      textColor: enabled ? Colors.black : Colors.grey,
      child: new Text(text),
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      minWidth: 0.0,
    );

    if(enabled){
      button = new Container(
        decoration: new BoxDecoration(
          border: new Border.all(),
          borderRadius: new BorderRadius.circular(3.0),
        ),
        child: button,
      );
    }

    return button;
  }

  Widget buildContent(int remainingActive){
    if( user == null) {
      return new LoadingIndicator();
    } else {

    }
  }

  @override
  Widget build(BuildContext context){
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Chat"),
        backgroundColor: Colors.green,

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
                  onPressed:(){
                    showAddContactDialog(context);
                  },
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
                /*new MaterialButton(
                  height: buttonHeight,
                  minWidth: buttonMinWidth,
                  color: Colors.lightBlueAccent,
                  splashColor: Colors.greenAccent,
                  textColor: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.chat_bubble_outline),
                      new Text("Test Call Skype"),
                    ],
                  ),
                  onPressed:() => testSkypeCall(),
                ),*/
              ]
          )
      ),
    );
  }

  void saveContact() async{
    contactStore = new ContactStore.forUser(user: user);

    //TODO get device info check if contact is already added if not then add contact and save it
    //Contact newContact = new Contact();
    String skypeName = acd.contactName;
    String skypeId = acd.contactSkypeName;
    bool isServiceProvider = acd.serviceProvider;
    String newServiceProviderName = acd.serviceProviderName;

    try{
      //contactProvider.insertContact(newContact);
      contactStore.createSkype(skypeName, skypeId, isServiceProvider, newServiceProviderName);
    } catch(e){
      print("[$TAG : ERROR] - Insert Contact Exception : $e");
    }
  }
}