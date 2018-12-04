package au.org.nac.dcvsapp

import android.os.Bundle

import android.content.ComponentName
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.content.pm.PackageManager
import android.database.Cursor
import android.graphics.drawable.AnimationDrawable
import android.net.Uri

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity(): FlutterActivity() {

  private val CHANNEL = "au.org.nac.io/skypeCalls"
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

      /*MethodChannel(flutterView, CHANNEL).setMethodCallHandler{call, result ->
          if(call.method == "openSkype"){
              openSkype()
          } else if(call.method == "callContact"){
              //text = call.argument("text");
              //println("Skype Call: ${call.argument("text")}")
              try{
                  makeSkypeCall(call.argument("text"))
              } catch (e: Exception){
                  println("Skype Call Error: $e")
              }
          }
      }*/
  }


    fun makeSkypeCall(mySkypeUri: String) {
        val skypeUri = Uri.parse(mySkypeUri)
        println("Make Skype Call $skypeUri");
        val intent = Intent(Intent.ACTION_VIEW, skypeUri)
        intent.setComponent(ComponentName("com.skype.raider", "com.skype.raider.Main"))
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        this.startActivity(intent)
    }

    fun isSkypeInstalled(context: Context): Boolean {
        val pkm = context.getPackageManager()
        try {
            pkm.getPackageInfo("com.skype.raider", PackageManager.GET_ACTIVITIES)
        } catch (e: PackageManager.NameNotFoundException) {
            return false
        }

        return true
    }

    private fun goToPlayStore(context: Context) {
        val mUri = Uri.parse("market://details?id=com.skype.raider")
        val intent = Intent(Intent.ACTION_VIEW, mUri)
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }

    fun openSkype() {
        val intent: Intent
        val pkm = this.getPackageManager()
        intent = pkm.getLaunchIntentForPackage("com.skype.raider")
        intent.addCategory(Intent.CATEGORY_LAUNCHER)
        startActivity(intent)
    }
}
