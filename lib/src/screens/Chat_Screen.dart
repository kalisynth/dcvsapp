part of dcvsapp;

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatState();
}

class AddContactData {
  String contactName;
  String contactSkypeName;
  String serviceProviderName;
  bool serviceProvider;
}

AddContactData acd = new AddContactData();

class ChatState extends State<ChatScreen> {
  //General Vars
  String TAG = "CHATSCREEN";
  //Form Vars
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autoValidate = false;
  bool checkValue = false;
  //Firebase Vars
  FirebaseUser user;
  ContactStore contactStore;
  StreamSubscription<QuerySnapshot> contactSub;
  List<SkypeItem> contacts;

  final _chatColor = DefaultSettings().chatColor;

  //Add Contact popup form
  Future<Null> showAddContactDialog(BuildContext context) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
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
                      onSaved: (String value) {
                        acd.contactName = value;
                      },
                    ),
                    new TextFormField(
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'johnsmith2934',
                        labelText: 'Skype Name:',
                      ),
                      onSaved: (String value) {
                        acd.contactSkypeName = value;
                      },
                    ),
                    new Row(children: <Widget>[
                      new Text("Service Provider?"),
                      new Checkbox(
                        value: checkValue,
                        onChanged: (bool newValue) {
                          setState(() {
                            checkValue = newValue;
                          });
                        },
                      )
                    ]),
                    new TextFormField(
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: 'dcvs',
                        labelText: 'Service Provider Name:',
                      ),
                      onSaved: (String value) {
                        acd.serviceProviderName = value;
                      },
                    ),
                    new FlatButton(
                        child: new Text("Add"),
                        onPressed: () {
                          _handleNameSubmitted();
                          Navigator.of(context).pop();
                        })
                  ]),
            )),
          );
        });
  }

  void _handleNameSubmitted() {
    final FormState form = _formKey.currentState;
    form.save();
    acd.serviceProvider = checkValue;
    saveContact();
  }

  void openSkypeTest() {
    AppAvailability.launchApp('com.skype.raider');
  }

  void testSkypeCall() async {
    String contact = "coconutdcvs";
    var url = "skype:$contact?call&video=true";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //dcvsUtils.
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    //uiSetup();
    super.initState();

    contacts = [];

    _auth.currentUser().then((FirebaseUser user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        contactStore = new ContactStore.forUser(user: user);
        contactSub?.cancel();
        contactSub = contactStore.skypeList().listen((QuerySnapshot snapshot) {
          final List<SkypeItem> contacts = snapshot.documents
              .map(ContactStore.fromDocument)
              .toList(growable: false);
          setState(() {
            this.contacts = contacts;
            print("Contacts Length = ${contacts.length}");
          });
        });

        setState(() {
          this.user = user;
        });
      }
    });
  }

  @override
  void dispose() {
    contactSub?.cancel();
    super.dispose();
  }

  Widget buildContent() {
    if (user == null) {
      return new LoadingIndicator();
    } else {
      return new Column(children: <Widget>[
        new ContactHeaderWidget(
          key: new Key('contact-header'),

        ),
        new Expanded(
            flex: 2,
            child: new ListView.builder(
              key: const Key('contact-list'),
              itemCount: contacts.length,
              itemBuilder: _buildContactItem(contacts),
            ))
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: _chatColor,
      body: new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image:
                    new AssetImage("assets/images/backgrounds/chat_bg.png"))),
        child: buildContent(),
      ),
      bottomNavigationBar: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new MaterialButton(
                  height: 10.0,
                  minWidth: 10.0,
                  color: Colors.blue,
                  splashColor: Colors.greenAccent,
                  textColor: Colors.black,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.add),
                      new Text("Add Contact"),
                    ],
                  ),
                  onPressed: () {
                    showAddContactDialog(context);
                  },
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 15.0)
                ),
                new MaterialButton(
                  height: 10.0,
                  minWidth: 10.0,
                  color: Colors.lightBlueAccent,
                  splashColor: Colors.greenAccent,
                  textColor: Colors.white,
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.chat_bubble_outline),
                      new Text("Open Skype"),
                    ],
                  ),
                  onPressed: () => openSkypeTest(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IndexedWidgetBuilder _buildContactItem(List<SkypeItem> contacts) {
    return (BuildContext context, int idx) {
      final SkypeItem skype = contacts[idx];
      return new SkypeWidget(
        key: new Key('skype-${skype.id}'),
        contact: skype,
        onCall: () {
          this._callContact(skype.skypeId);
        },
        onDelete: () {
          this._deleteContact(skype);
        },
      );
    };
  }

  Future<Null> _callContact(String skypeContact) async {
    var url = "skype:$skypeContact?call&video=true";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _deleteContact(SkypeItem item) {
    contactStore.deleteContact(item.id);
  }

  void saveContact() async {
    contactStore = new ContactStore.forUser(user: user);

    //TODO get device info check if contact is already added if not then add contact and save it
    //Contact newContact = new Contact();
    String skypeName = acd.contactName;
    String skypeId = acd.contactSkypeName;
    bool isServiceProvider = acd.serviceProvider;
    String newServiceProviderName = acd.serviceProviderName;

    try {
      //contactProvider.insertContact(newContact);
      contactStore.createSkype(
          skypeName, skypeId, isServiceProvider, newServiceProviderName);
    } catch (e) {
      print("[$TAG : ERROR] - Insert Contact Exception : $e");
    }
  }

  void addDcvsContacts() async{
    contactStore = new ContactStore.forUser(user: user);

  }
}
