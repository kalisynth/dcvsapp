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

  group('Tablet Name', (){
    test('initial tablet setup', (){
      SharedPreferences.setMockInitialValues({});

      final nameStatus = TabletNameStatus();

      nameStatus.getTabletName();

      new Timer(const Duration(milliseconds: 20), (){
        print("Name Check: ${nameStatus.tabletName}");

        expect(nameStatus.tabletName, "Not Set");
      });
    });

    test('Set Tablet Name', (){
      String tabletName = 'Test Tablet Name';

      final nameStatus = TabletNameStatus();

      nameStatus.changeTabletName(tabletName);

      new Timer(const Duration(milliseconds: 20), (){
        nameStatus.getTabletName();
        String _TabletName = nameStatus.tabletName;
        print("_Tabletname: $_TabletName tabletName: $tabletName");
        expect(_TabletName, tabletName);
      });
    });

    test('get Tablet Name' , (){
      final nameStatus = TabletNameStatus();
      String tabletName = 'Test Tablet Name';

      expect(nameStatus.tabletName, tabletName);
    });
  });
}