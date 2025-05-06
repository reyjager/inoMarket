import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:inomarket/auth/helper/auth_result.dart';
import 'package:stacked/stacked.dart';

class SignupViewmodel extends BaseViewModel {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  bool showPassword = false;
  String? _errorMessage;

  String get errorMessage => _errorMessage ?? "";

  togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  bool gotError() {
    return _errorMessage != null;
  }

  goToPrivacyPolicy() {}
  goToUsagePolicy() {}
  login() {
    Get.back(result: AuthResult.chooseToLogin);
  }

  submit() async {
    // try {
    //   stage = RegisterStage.loading;
    //   _errorMessage = null;
    //   notifyListeners();
    String phone = _validatePhone();
    //   String password = _validatePassword();
    //   String name = _validateName();

    //   verifiedName = name;
    //   verifiedPassword = password;
    //   verifiedPhone = phone;

    //   print(verifiedPhone);

    //   await authService.register(name, phone, password);
    //   stage = RegisterStage.otp;
    //   notifyListeners();
    // } catch (e) {
    //   _errorMessage = e.toString();
    //   stage = RegisterStage.fillUpForm;
    //   notifyListeners();
    //   return;
    // }
  }

  String _validatePhone() {
    String phone = phoneCtrl.text;
    if (!phone.startsWith('05')) {
      throw 'Incorrect phone number';
    }

    if (phone.length != 10) {
      throw 'Incorrect phone number';
    }

    try {
      int phoneInt = int.parse(phone);
      return "966$phoneInt";
    } catch (e) {
      throw 'Incorrect phone number';
    }
  }

  String _validatePassword() {
    String password = passwordCtrl.text;

    if (password.length < 6) {
      throw 'Password Error';
    }

    return password;
  }

  String _validateName() {
    String name = nameCtrl.text;

    if (name.length < 3) {
      throw 'Name must be complete';
    }
    return name;
  }
}
