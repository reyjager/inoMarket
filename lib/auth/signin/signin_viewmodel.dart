import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:inomarket/auth/reset_password/reset_password_view.dart';
import 'package:inomarket/auth/signup/signup_view.dart';
import 'package:stacked/stacked.dart';

class SignInViewmodel extends BaseViewModel {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? "";

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  bool gotError() {
    return _errorMessage != null;
  }

  login() {}

  forgotPassword() {
    Get.to(const ForgotPasswordView());
  }

  createAccount() {
    Get.to(() => const SignupView(),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 400));
  }
}
