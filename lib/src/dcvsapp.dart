library dcvsapp;

//FLUTTER IMPORTS
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//3rd Party imports
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart';

//Google imports
import 'package:cloud_firestore/cloud_firestore.dart';

//SCREENS
part 'screens/Home_Screen.dart';
part 'screens/Options_Screen.dart';
part 'screens/Fun_Screen.dart';
part 'screens/Chat_Screen.dart';

//INTERFACE
part 'interface/DCVS_Widgets.dart';
part 'interface/DCVS_Syncs.dart';

//Widget
part 'interface/Widgets/ContactListItem.dart';

//DATA
part 'Data/DCVS_SharedKeys.dart';
part 'Data/DCVS_NavLinks.dart';
part 'Data/DefaultSettings.dart';

//Models
part 'Data/Models/Contact.dart';
part 'Data/Models/Tablet_Model.dart';

//Providers
part 'Data/Providers/ContactProvider.dart';
part 'Data/Providers/Tablet_Storage.dart';

navigationLinks navLinks = new navigationLinks();
DCVSSyncs dcvsSyncs = new DCVSSyncs();
DCVSSharedKeys dcvsKeys = new DCVSSharedKeys();
DefaultSettings getDefault = new DefaultSettings();

class DCVSAPP extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "DCVS Connect",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.lightBlueAccent
      ),
      home: new MainScreen(),
      routes: <String, WidgetBuilder>{
        navLinks.NL_homeScreen : (BuildContext context) => new HomeScreen(),
        navLinks.NL_chatScreen : (BuildContext context) => new ChatScreen(),
        navLinks.NL_optionsScreen : (BuildContext context) => new OptionsScreen(),
        navLinks.NL_funScreen : (BuildContext context) => new FunScreen(),
      }
    );
  }
}