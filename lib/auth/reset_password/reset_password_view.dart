import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inomarket/auth/reset_password/reset_password_viewmodel.dart';
import 'package:inomarket/themes/theme_service.dart';
import 'package:inomarket/widget/message/message_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      builder: (
        BuildContext context,
        ForgotPasswordViewModel model,
        Widget? child,
      ) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: const Text('reset password')),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stepper(
                    type: StepperType.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    onStepContinue: model.stepChanged,
                    onStepTapped: model.onStepTapped,
                    onStepCancel: model.cancelReset,
                    currentStep: model.currentStep,
                    steps: [
                      Step(
                        isActive: model.currentStep == 0,
                        title: const Text('accountVerification'),
                        subtitle: const Text('enterMobile'),
                        content: !model.isLoading
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: TextField(
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                    labelText: 'phone Number',
                                    hintText: "مثال: 05xxxxxxxx",
                                    prefixIcon: Icon(Icons.phone),
                                  ),
                                  controller: model.phoneCtrl,
                                  keyboardType: TextInputType.phone,
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                    color: ThemeService
                                        .currentColorScheme.primaryColor),
                              ),
                      ),
                      Step(
                        isActive: model.currentStep == 1,
                        title: const Text('confirm Number'),
                        subtitle: const Text('otp Code'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: PinCodeTextField(
                                  enablePinAutofill: true,
                                  autoUnfocus: true,
                                  // obscureText: true,2
                                  appContext: context,
                                  // focusNode: ,
                                  autoFocus: true,
                                  length: 4,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  autoDismissKeyboard: true,
                                  blinkWhenObscuring: true,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    borderWidth: 0,
                                    activeColor: ThemeService
                                        .currentColorScheme.primaryColor[200],
                                    inactiveColor: ThemeService
                                        .currentColorScheme.primaryColor[200],
                                    selectedColor: ThemeService
                                        .currentColorScheme.primaryColor[200],
                                    activeFillColor: ThemeService
                                        .currentColorScheme.primaryColor[200],
                                    inactiveFillColor: ThemeService
                                        .currentColorScheme.primaryColor[200],
                                    selectedFillColor: ThemeService
                                        .currentColorScheme.primaryColor[200],
                                  ),
                                  textStyle:
                                      const TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  enableActiveFill: true,
                                  controller: model.otpCtrl,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => model.clearError(),
                                ),
                              ),
                              Visibility(
                                visible: model.isCounting,
                                replacement: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: ThemeService
                                          .currentColorScheme.primaryColor[200],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: InkWell(
                                    onTap: () {
                                      // model.sendOTP();
                                      model.startCountDown();
                                    },
                                    child: Text(
                                      'resendCode',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: ThemeService
                                              .currentColorScheme.primaryColor),
                                    ),
                                  ),
                                ),
                                child: Obx(
                                  () => Text(
                                    model.time.value,
                                  ),
                                ),
                                // 0565203372
                              ),
                            ],
                          ),
                        ),
                      ),
                      Step(
                        isActive: model.currentStep == 2,
                        title: const Text('enterNewPass'),
                        content: !model.isLoading
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'pass',
                                        hintText: 'passHint',
                                        prefixIcon: const Icon(Icons.lock),
                                      ),
                                      controller: model.passwordCtrl,
                                      obscureText: true,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        labelText: 'confirmPass',
                                        hintText: 'passHint',
                                        prefixIcon: Icon(Icons.lock),
                                      ),
                                      controller: model.confirmPasswordCtrl,
                                      obscureText: true,
                                    ),
                                  )
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: model.gotError(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MessageWidget(
                        content: model.errorMessage,
                        type: MessageType.danger,
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
