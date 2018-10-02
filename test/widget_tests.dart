import 'package:test/test.dart';
import 'package:dcvs_app/src/dcvsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main(){
  group('Button Height', (){
    test('Initial Button Height Test', (){
      SharedPreferences.setMockInitialValues({});
      final buttonCheck = ButtonStyleCheck();
      Timer timer;

      buttonCheck.getButtonHeight();
      timer = new Timer(const Duration(milliseconds: 20), (){
        print("Height Check: ${buttonCheck.heightValue}");

        expect(buttonCheck.heightValue, 10.0);
      });
    });

    test('Change Button Height', (){
      final buttonSetup = SetupButtonStyle();
      double changeValue = 20.0;

      buttonSetup.changeHeight(changeValue);

      new Timer(const Duration(milliseconds: 20), (){
        final buttonCheck = ButtonStyleCheck();

        expect(buttonCheck.heightValue, changeValue);
      });
    });
  });

  group('Button Width', (){
    test('Check Initial Button Width', (){
      SharedPreferences.setMockInitialValues({});
      final buttonCheck = ButtonStyleCheck();

      buttonCheck.getButtonWidth();
      Timer _timer = new Timer(const Duration(milliseconds: 20), (){
        print("Height Check: ${buttonCheck.widthValue}");

        expect(buttonCheck.widthValue, 30.0);
      });
    });

    test('Change Button Width', (){
      final buttonSetup = SetupButtonStyle();
      double changeValue = 60.0;

      buttonSetup.changeWidth(changeValue);

      Timer timer = new Timer(const Duration(milliseconds: 20), (){
        final buttonCheck = ButtonStyleCheck();

        expect(buttonCheck.widthValue, changeValue);
      });
    });
  });
}