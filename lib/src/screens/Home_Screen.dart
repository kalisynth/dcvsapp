part of dcvsapp;

class MainScreen extends StatefulWidget{

  @override
  State createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen>with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isScrollEnabled = true;

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
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blue,
              isScrollable: isScrollEnabled,
              tabs: <Widget>[
                Tab(text: "Home", icon: Icon(Icons.home),),
                Tab(text: "Chat", icon: Icon(Icons.people),),
                Tab(text: "Fun", icon: Icon(Icons.games),),
                Tab(text: "Options", icon: Icon(Icons.settings)),
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
            image: new AssetImage("assets/images/backgrounds/home_bg.png"),
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