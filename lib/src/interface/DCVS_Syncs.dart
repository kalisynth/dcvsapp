part of dcvsapp;

class DCVSSyncs{
  String TAG = "DCVSSYNC";

  //Set shared string, if succeeds return true else return false
  Future<bool> setSharedString(String sharedKey, String sharedString) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Setting $sharedString for $sharedKey");
    try{
      prefs.setString(sharedKey, sharedString);
      return true;
    } catch(e){
      print("[$TAG : ERROR $e");
      return false;
    }
  }

  //Set shared int, if succeeds return true else return false
  Future<bool> setSharedInt(String sharedKey, int sharedInt) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Setting $sharedInt for $sharedKey");
    try{
      prefs.setInt(sharedKey, sharedInt);
      return true;
    } catch(e){
      print("[$TAG : ERROR $e");
      return false;
    }
  }

  //Set Shared Double
  Future<bool> setSharedDouble(String sharedKey, double sharedDouble) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Setting $sharedDouble for $sharedKey");
    try{
      prefs.setDouble(sharedKey, sharedDouble);
      return true;
    } catch(e){
      print("[$TAG : ERROR $e");
      return false;
    }
  }

  //set shared bool
  Future<bool> setSharedBool(String sharedKey, bool sharedBool) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Setting $sharedBool for $sharedKey");
    try{
      prefs.setBool(sharedKey, sharedBool);
      return true;
    } catch(e){
      print("[$TAG : ERROR $e");
      return false;
    }
  }

  //Get Shared String
  Future<String> getSharedString(String sharedKey) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Getting $sharedKey");
    String newSharedString;
    try{
      newSharedString = await prefs.getString(sharedKey);
      return newSharedString;
    } catch(e){
      print("[$TAG : ERROR $e");
      return " ";
    }
  }

  //get shared int
  Future<int> getSharedInt(String sharedKey) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Getting $sharedKey");
    int newSharedInt;
    try{
      newSharedInt = await prefs.getInt(sharedKey);
      return newSharedInt;
    } catch(e){
      print("[$TAG : ERROR $e");
      return 0;
    }
  }

  //get shared double
  Future<double> getSharedDouble(String sharedKey) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Getting $sharedKey");
    double newSharedDouble;
    try{
      newSharedDouble = prefs.getDouble(sharedKey) ?? 0.0;
      return newSharedDouble;
    } catch(e){
      print("[$TAG : ERROR $e");
      return 0.0;
    }
  }

  //get Shared Bool
  Future<bool> getSharedBool(String sharedKey) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("[$TAG : INFO] - Getting $sharedKey");
    bool newBool;
    try{
      newBool = await prefs.getBool(sharedKey) ?? true;
      print("[$TAG : INFO] - $newBool");
      return newBool;
    } catch(e){
      print("[$TAG : ERROR $e");
      return false;
    }
  }
}