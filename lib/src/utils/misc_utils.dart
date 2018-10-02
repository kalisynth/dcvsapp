part of dcvsapp;

class Utils{
  bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  void printInfo(String tag, String message){
    if(isInDebugMode){
      print("[$tag : INFO] $message");
    }
  }

  void printError(String tag, String message){
    if(isInDebugMode){
      print("[$tag : ERROR] $message");
    }
  }
}