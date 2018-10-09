library dcvsapp;

//IMPORTS-------------------------------
//FLUTTER IMPORTS-----------------------
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
//--------------------------------------
//3rd Party imports---------------------------------------------------
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:device_info/device_info.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:simple_permissions/simple_permissions.dart';
//--------------------------------------------------------------------
//Google imports-------------------------------------------------
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//--------------------------------------------------------------------
//-------------------------------------------------------------------

//PARTS---------------------------------------------------------------
//SCREENS----------------------------
part 'screens/Home_Screen.dart';
part 'screens/Options_Screen.dart';
part 'screens/Fun_Screen.dart';
part 'screens/Chat_Screen.dart';
part 'screens/Splash_Screen.dart';
part 'screens/fun_sub_screens/games_screen.dart';
part 'screens/fun_sub_screens/radio_screen.dart';
part 'screens/fun_sub_screens/web_screen.dart';
//-----------------------------------
//INTERFACE-------------------------
part 'interface/DCVS_Widgets.dart';
part 'interface/DCVS_Syncs.dart';
//----------------------------------
//Utils---------------------------
part 'utils/misc_utils.dart';
part 'utils/authentication.dart';
part 'utils/DCVS_DEVICE.dart';
//--------------------------------
//Widget-----------------------------------------
part 'interface/Widgets/loading_indicator.dart';
part 'interface/Widgets/skype_widget.dart';
part 'interface/Widgets/contact_header.dart';
//-----------------------------------------------
//DATA-------------------------------------------
part 'Data/DCVS_SharedKeys.dart';
part 'Data/DCVS_NavLinks.dart';
part 'Data/DefaultSettings.dart';
//----------------------------------------------
//Models----------------------------------------
part 'Data/Models/Device_Model.dart';
part 'Data/Models/User_Model.dart';
part 'Data/Models/skype_item.dart';
part 'Data/Models/game_item.dart';
//----------------------------------------------
//Providers-------------------------------------
part 'Data/Providers/Data_Storage.dart';
//----------------------------------------------
//----------------------------------------------

NavigationLinks navLinks = new NavigationLinks();
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
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        navLinks.linkMainScreen : (BuildContext context) => new MainScreen(),
        navLinks.linkHomeScreen : (BuildContext context) => new HomeScreen(),
        navLinks.linkChatScreen : (BuildContext context) => new ChatScreen(),
        navLinks.linkOptionsScreen : (BuildContext context) => new OptionsScreen(),
        navLinks.linkFunScreen : (BuildContext context) => new FunScreen(),
      }
    );
  }
}