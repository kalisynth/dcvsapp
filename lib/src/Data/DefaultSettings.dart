part of dcvsapp;

class DefaultSettings{
  final bool defaultSwipeEnabled = true;
  final double defaultButtonHeight = 10.0;
  final double defaultButtonWidth = 30.0;
  final String defaultTabletName = "Not Set";
  final Color chatColor = new Color(Utils().hexToInt("FF27FFFF")); //cool mint
  final Color homeColor = new Color(Utils().hexToInt("FFa1bbff")); //lilac
  final Color funColor = new Color(Utils().hexToInt("FFfCCE66")); //light pumpkin
  final Color optionsColor = new Color(Utils().hexToInt("FFEC94A1")); //salmon
  final Color gamesBGColor = Colors.green;
  final Color gamesFontColor = Colors.yellow;
  final Color radioBGColor = Colors.yellow;
  final Color radioFontColor = Colors.green;
  final Color webBGColor = Colors.blueGrey;
  final Color webFontColor = Colors.white;
}