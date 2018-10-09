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
    return new DefaultTabController(
        length: 3,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
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
                      new Icon(Icons.games),
                      new Text("Games",
                        style: new TextStyle(
                          color: Colors.lightGreen,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 10.0)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.web),
                      new Text("Web",
                        style: new TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 10.0)),
                    ]
                ),),
                Tab(child: new Row(
                    children:<Widget>[
                      new Icon(Icons.radio),
                      new Text("Radio",
                        style: new TextStyle(
                          color: Colors.amberAccent,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(right: 10.0)),
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
              ]
          ),
        )
    );
  }
}