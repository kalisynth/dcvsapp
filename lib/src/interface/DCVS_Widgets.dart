part of dcvsapp;

class DCVSOverlay{

  MaterialButton navBarButton(IconData icon, String text, BuildContext context, String screenName, {double buttonHeight, double buttonMinWidth, Color buttonColor, Color buttonSplashColor, Color buttonTextColor}){
    if(buttonHeight == null){
      buttonHeight = 10.0;
    }

    if(buttonMinWidth == null){
      buttonMinWidth = 50.0;
    }

    if(buttonColor == null){
      buttonColor = Colors.white;
    }

    if(buttonSplashColor == null){
      buttonSplashColor = Colors.lightBlueAccent;
    }

    if(buttonTextColor == null){
      buttonTextColor = Colors.black;
    }

    return new MaterialButton(
      height: buttonHeight,
      minWidth: buttonMinWidth,
      color: buttonColor,
      splashColor: buttonSplashColor,
      textColor: buttonTextColor,
      child: new Column(
        children: <Widget>[
          new Icon(icon),
          new Text(text),
        ],
      ),
      onPressed:() => Navigator.of(context).pushNamed(screenName),
    );
  }

  ButtonBar homePageBar(BuildContext context){
    return new ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        navBarButton(Icons.people, "CHAT", context, navLinks.linkChatScreen, buttonColor: Colors.blueGrey),
        navBarButton(Icons.games, "FUN", context, navLinks.linkFunScreen, buttonColor: Colors.amber),
        navBarButton(Icons.settings, "OPTIONS", context, navLinks.linkOptionsScreen, buttonColor: Colors.green),
        navBarButton(Icons.home, "HOME", context, navLinks.linkHomeScreen, buttonColor: Colors.redAccent),
      ],
    );
  }
}

void showInSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String value){
  scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)
  ));
}

class ScrollCheck{
  bool enabled = getDefault.defaultSwipeEnabled;
  void isEnabled() async => enabled = await dcvsSyncs.getSharedBool('swipeNavKey');
}

class ScrollChange{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void enable() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('swipeNavKey', true);
    print('set swipeNavKey to ${prefs.getBool('swipeNavKey')}');
  }

  void disable() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('swipeNavKey', false);
    print('set swipeNavKey to ${prefs.getBool('swipeNavKey')}');
  }
}

class ButtonStyleCheck{
  double defaultHeight = getDefault.defaultButtonHeight;
  double defaultWidth = getDefault.defaultButtonWidth;
  double heightValue = 0.0;
  double widthValue = 0.0;
  double _value = 0.0;

  void getButtonHeight() async{
    _value = await dcvsSyncs.getSharedDouble('buttonHeight');
    if(_value == 0.0){
      heightValue = defaultHeight;
    } else {
      heightValue = _value;
    }
  }

  void getButtonWidth() async{
    _value = await dcvsSyncs.getSharedDouble('buttonWidth');
    if(_value == 0.0){
      widthValue = defaultWidth;
    } else {
      widthValue = _value;
    }
  }
}

class SetupButtonStyle{

  void changeHeight(double value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('buttonHeight', value);
  }

  void changeWidth(double value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('buttonWidth', value);
  }
}