import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inomarket/auth/reset_password/change_password_successfully.dart';
import 'package:inomarket/auth/signin/signin_view.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController otpCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  String? _errorMessage;
  bool isLoading = false;
  String get errorMessage => _errorMessage ?? "";
  bool gotError() {
    return _errorMessage != null;
  }

  Timer? _timer;
  bool isCounting = false;
  int remainingSeconds = 1;
  final time = '00.00'.obs;
  int currentStep = 0;
  startCountDown() {
    isCounting = true;
    if (_errorMessage != null) {
      return;
    }
    notifyListeners();
    _startTimer(300);
  }

  _startTimer(int seconds) {
    print("[DEBUG] TIMER START $isCounting");
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (timer) {
      print('[DEBUG] TIMER : ${timer.isActive}');
      if (remainingSeconds < 0) {
        isCounting = false;
        timer.cancel();
        notifyListeners();
      } else {
        int minutes = (remainingSeconds ~/ 60);
        int seconds = (remainingSeconds % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
    //
  }

  verifyEnteredCode(String otp) {
    if (otp.length < 4) {
      throw ('enterCodeSentPhone');
    }
  }

  onStepTapped(int step) {
    if (currentStep < step) {
      return;
    }
    currentStep = step;
    notifyListeners();
  }

  clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  stepChanged() async {
    switch (currentStep) {
      case 0:
        clearError();
        await stepOne();
        if (_errorMessage != null) {
          break;
        }
        currentStep++;
        startCountDown();
        notifyListeners();
        break;
      case 1:
        try {
          clearError();
          verifyEnteredCode(otpCtrl.text);
          _timer?.cancel();
          currentStep = 2;
          notifyListeners();
        } catch (e) {
          _errorMessage = e.toString();
          notifyListeners();
          break;
        }
        break;
      case 2:
        clearError();
        try {
          await verifyAndChangePassword();
        } catch (e) {
          _errorMessage = e.toString();
          notifyListeners();
        }
        break;
      default:
    }
  }

  stepOne() async {
    // clearError();
    // await sendOTP();
    // notifyListeners();
    // if (_errorMessage == null) {
    //   print("[DEBUG] This true number");
    // }
  }

  verifyAndChangePassword() async {
    // check password is same confirmed
    // if (passwordCtrl.text != confirmPasswordCtrl.text) {
    //   throw tr('passNotMatch');
    // }
    // // 1- api request
    // notifyListeners();
    // if (phoneCtrl.text.isEmpty ||
    //     passwordCtrl.text.isEmpty ||
    //     otpCtrl.text.isEmpty) {
    //   throw 'fieldEmpty';
    // }
    // isLoading = true;

    // Map<String, dynamic> response = await AuthService().changePassword(
    //   mobile: phoneCtrl.text,
    //   otp: otpCtrl.text,
    //   password: passwordCtrl.text,
    // );
    // isLoading = false;
    // inspect(response['status']);
    // notifyListeners();
    // isLoading = false;
    // if (response['status'] == 0) {
    //   _errorMessage = 'wrongCodeEntered';
    //   notifyListeners();
    //   return;
    // }

    Get.offAll(
      const PasswordChangedSuccessfullyView(),
    );

    notifyListeners();
  }

  // sendOTP() async {
  //   try {
  //     // 1- validate phone number
  //     String phone = _validatePhone();
  //     //  2- request otp
  //     isLoading = true;
  //     notifyListeners();
  //     Map<String, dynamic> response = await AuthService().sendOTP(phone);
  //     inspect(response['status']);
  //     notifyListeners();
  //     isLoading = false;
  //     if (response['status'] == 0) {
  //       _errorMessage = response['msg'];
  //       notifyListeners();
  //       return;
  //     }
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     return;
  //   }
  // }

  cancelReset() {
    Get.to(const SigninView());
  }

  String _validatePhone() {
    _errorMessage = null;
    String phone = phoneCtrl.text;
    // if (!phone.startsWith('05')) {
    //   throw ("رقم الهاتف غير صحيح");
    // }

    // if (phone.length != 10) {
    //   // return _errorMessage = "رقم الهاتف غير صحيح";
    //   throw ("رقم الهاتف غير صحيح");
    // }

    try {
      int phoneInt = int.parse(phone);
      return "$phoneInt";
    } catch (e) {
      throw ('phoneError');
    }
  }
}
