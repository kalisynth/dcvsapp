import 'package:test/test.dart';
import 'package:dcvs_app/src/dcvsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main(){

  group('Scroll Check', (){
    test('Initial Scroll Check', (){
      SharedPreferences.setMockInitialValues({});
      final scrollCheck = ScrollCheck();
      Timer _timer;

      scrollCheck.isEnabled();

      _timer = new Timer(const Duration(milliseconds: 20), (){
        print("Scroll Check - ${scrollCheck.enabled}");

        expect(scrollCheck.enabled, getDefault.defaultSwipeEnabled);
      });
    });

    test('Change Scroll to enabled', (){
      final scrollChange = ScrollChange();
      scrollChange.enable();

      Timer timer = new Timer(const Duration(milliseconds: 20), (){
        final scrollCheck = ScrollCheck();

        expect(scrollCheck.enabled, true);
      });
    });

    test('Change Scroll to disabled', (){
      final scrollChange = ScrollChange();
      scrollChange.disable();

      Timer timer = new Timer(const Duration(milliseconds: 20), (){
        final scrollCheck = ScrollCheck();

        expect(scrollCheck.enabled, false);
      });
    });

    test('Ui Setup', (){
      bool isScrollEnabled = true;

      final mainScreen = MainScreenState();

      mainScreen.uiSetup();

      expect(isScrollEnabled, true);
    });
  });
}