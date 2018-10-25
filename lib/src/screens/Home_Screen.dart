part of dcvsapp;

class MainScreen extends StatefulWidget{
  static final ScrollCheck scrollCheck = new ScrollCheck();
  final bool _enabled = scrollCheck.enabled;

  @override
  State createState(){
    if(!_enabled){
      return new MainScreenStateNoSwipe();
    }
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen>with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isScrollEnabled = true;
  static const double tabPadding = 20.0;
  static const double textScaleDbl = 3.0;
  static const double iconSizeDbl = 40.0;

  void uiSetup(){
    final scrollCheck = ScrollCheck();

    bool scrollEnabled = scrollCheck.enabled;

    Timer timer = new Timer(const Duration(milliseconds: 20), (){
      setState((){
        if(scrollEnabled == null){
          isScrollEnabled = true;
        } else {
          isScrollEnabled = scrollEnabled;
        }
      });
    });
  }

  void newTablet() async{
    String newUID;


  }

  @override
  void initState() {
    uiSetup();
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return new DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: new Text("DCVS Connect"),
            backgroundColor: Colors.black,
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
              isScrollable: true,
              tabs: <Widget>[
                Tab(child: new Row(
                  children:<Widget>[
                    new Icon(Icons.home, size: iconSizeDbl,),
                    new Text("Home",
                        style: new TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      textScaleFactor: textScaleDbl,
                    ),
                    Padding(padding: const EdgeInsets.only(right: tabPadding)),
                  ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.people, size: iconSizeDbl),
                      new Text("Chat",
                        style: new TextStyle(
                          color: Colors.green,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.games, size: iconSizeDbl),
                      new Text("Fun",
                        style: new TextStyle(
                          color: Colors.amberAccent,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.settings, size: iconSizeDbl),
                      new Text("Options",
                        style: new TextStyle(
                          color: Colors.redAccent,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
              ],
            ),
          ),
          body: new TabBarView(
              children: <Widget>[
                new HomeScreen(),
                new ChatScreen(),
                new FunScreen(),
                new OptionsScreen(),
              ]
          ),
        )
    );
  }
}

class MainScreenStateNoSwipe extends State<MainScreen>with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isScrollEnabled = true;
  static const double tabPadding = 20.0;
  static const double textScaleDbl = 3.0;
  static const double iconSizeDbl = 40.0;

  void uiSetup(){
    final scrollCheck = ScrollCheck();

    bool scrollEnabled = scrollCheck.enabled;

    Timer timer = new Timer(const Duration(milliseconds: 20), (){
      setState((){
        if(scrollEnabled == null){
          isScrollEnabled = true;
        } else {
          isScrollEnabled = scrollEnabled;
        }
      });
    });
  }

  void newTablet() async{
    String newUID;


  }

  @override
  void initState() {
    uiSetup();
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return new DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: new Text("DCVS Connect"),
            backgroundColor: Colors.black,
            textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
              isScrollable: true,
              tabs: <Widget>[
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.home, size: iconSizeDbl,),
                      new Text("Home",
                        style: new TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.people, size: iconSizeDbl),
                      new Text("Chat",
                        style: new TextStyle(
                          color: Colors.green,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.games, size: iconSizeDbl),
                      new Text("Fun",
                        style: new TextStyle(
                          color: Colors.amberAccent,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.settings, size: iconSizeDbl),
                      new Text("Options",
                        style: new TextStyle(
                          color: Colors.redAccent,
                        ),
                        textScaleFactor: textScaleDbl,
                      ),
                      Padding(padding: const EdgeInsets.only(right: tabPadding)),
                    ]
                ),),
              ],
            ),
          ),
          body: new TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                new HomeScreen(),
                new ChatScreen(),
                new FunScreen(),
                new OptionsScreen(),
              ]
          ),
        )
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  State createState() => new HomeState();
}

class HomeState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context){
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlueAccent,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/backgrounds/homeaur_bg.png"),
          ),
        ),
        child: new Column(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/backgrounds/img_eric.png"),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}