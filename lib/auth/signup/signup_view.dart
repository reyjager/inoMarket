import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inomarket/auth/signup/signup_viewmodel.dart';
import 'package:inomarket/themes/theme_service.dart';
import 'package:inomarket/widget/button/button_widget.dart';
import 'package:inomarket/widget/message/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignupViewmodel(),
      builder: (
        BuildContext context,
        SignupViewmodel model,
        Widget? child,
      ) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Text('Register New Account')),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Welcome',
                          style: ThemeService.headLine.copyWith(
                              color:
                                  ThemeService.currentColorScheme.primaryColor,
                              fontSize: 26),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'At the InoMarket platform. To register, please enter the required data in the following fields.xt',
                          style: ThemeService.normalText.copyWith(
                            color: ThemeService.currentColorScheme.primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          maxLength: 50,
                          controller: model.nameCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.0),
                              ),
                              borderSide: BorderSide(
                                color: ThemeService
                                    .currentColorScheme.primaryColor,
                                width: 4,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(9.0),
                              ),
                              borderSide: BorderSide(
                                color: ThemeService
                                    .currentColorScheme.backgroundColor[300]!,
                                width: 1,
                              ),
                            ),
                            labelText: 'Full Name',
                            hintText: 'Example: Juan DelaCruz',
                            prefixIcon: Icon(
                              FontAwesomeIcons.userLarge,
                              color: ThemeService
                                  .currentColorScheme.blackColor[100],
                            ),
                            counterText: "",
                          ),
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\u0600-\u06FF ]'),
                            ),
                          ],
                          style: ThemeService.smallText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          maxLength: 50,
                          obscureText: !model.showPassword,
                          controller: model.passwordCtrl,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.0),
                              ),
                            ),
                            counterText: "",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(9.0),
                              ),
                              borderSide: BorderSide(
                                color: ThemeService
                                    .currentColorScheme.backgroundColor[300]!,
                                width: 1,
                              ),
                            ),
                            labelText: 'password',
                            prefixIcon: Icon(
                              FontAwesomeIcons.unlockKeyhole,
                              color: ThemeService
                                  .currentColorScheme.blackColor[100],
                            ),
                            suffixIcon: IconButton(
                              onPressed: model.togglePasswordVisibility,
                              icon: Icon(
                                !model.showPassword
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                color: ThemeService
                                    .currentColorScheme.blackColor[100],
                              ),
                            ),
                          ),
                          style: ThemeService.smallText,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: model.phoneCtrl,
                          maxLength: 10,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(9.0),
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(9.0),
                                ),
                                borderSide: BorderSide(
                                  color: ThemeService
                                      .currentColorScheme.backgroundColor[300]!,
                                  width: 1,
                                ),
                              ),
                              labelText: 'phoneNumber',
                              hintText: 'مثال: 05xxxxxxxx',
                              prefixIcon: Icon(
                                FontAwesomeIcons.mobileScreenButton,
                                color: ThemeService
                                    .currentColorScheme.blackColor[100],
                              ),
                              counterText: ""),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                          ],
                          keyboardType: TextInputType.phone,
                          style: ThemeService.smallText,
                        ),
                      ),
                      MessageWidget(
                        type: MessageType.warning,
                        content: "",
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'By registering on the Atheer platform, you agree to',
                                style: ThemeService.smallText.copyWith(
                                  height: 1.2,
                                  color: ThemeService
                                      .currentColorScheme.blackColor,
                                ),
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: model.goToPrivacyPolicy,
                                    child: Text(
                                      'Privacy Policy',
                                      style: ThemeService.smallText.copyWith(
                                        color: ThemeService
                                            .currentColorScheme.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text("and"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: model.goToUsagePolicy,
                                    child: Text(
                                      'Terms of Use',
                                      style: ThemeService.smallText.copyWith(
                                          color: ThemeService
                                              .currentColorScheme.blackColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ButtonWidget(
                          text: 'New Registration',
                          onPressed: model.submit,
                          defineColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an Account?',
                            style: ThemeService.normalText.copyWith(
                              color: ThemeService.currentColorScheme.blackColor,
                            ),
                          ),
                          TextButton(
                            onPressed: model.login,
                            child: Text(
                              'Sign In',
                              style: ThemeService.normalText.copyWith(
                                color: ThemeService
                                    .currentColorScheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              )),
        );
      },
    );
  }
}
