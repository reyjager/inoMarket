import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inomarket/auth/signin/signin_viewmodel.dart';
import 'package:inomarket/themes/theme_service.dart';
import 'package:inomarket/widget/button/button_widget.dart';
import 'package:inomarket/widget/message/message_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';

class SigninView extends StatelessWidget {
  final bool afterResetPassword;
  const SigninView({super.key, this.afterResetPassword = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignInViewmodel(),
      builder: (
        BuildContext context,
        SignInViewmodel model,
        Widget? child,
      ) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text('Sign In'),
              ),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: model.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            color:
                                ThemeService.currentColorScheme.primaryColor),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Welcome Back',
                                style: ThemeService.headLine.copyWith(
                                  fontSize: 26,
                                  color: ThemeService
                                      .currentColorScheme.primaryColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              child: Text('at',
                                  style: ThemeService.normalText.copyWith(
                                    color: ThemeService.currentColorScheme
                                        .backgroundColor[300],
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextField(
                                      controller: model.phoneCtrl,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(9.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(9.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: ThemeService
                                                  .currentColorScheme
                                                  .backgroundColor[300]!,
                                              width: 1,
                                            ),
                                          ),
                                          labelText: 'phoneNumber',
                                          hintText: 'مثال: 05xxxxxxxx',
                                          prefixIcon: Icon(
                                            FontAwesomeIcons.mobileScreenButton,
                                            color: ThemeService
                                                .currentColorScheme
                                                .blackColor[100],
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextFormField(
                                      obscureText: !model.showPassword,
                                      controller: model.passwordCtrl,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(9.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(9.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: ThemeService
                                                .currentColorScheme
                                                .backgroundColor[300]!,
                                            width: 1,
                                          ),
                                        ),
                                        labelText: 'password',
                                        prefixIcon: Icon(
                                          FontAwesomeIcons.unlockKeyhole,
                                          color: ThemeService.currentColorScheme
                                              .blackColor[100],
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed:
                                              model.togglePasswordVisibility,
                                          icon: Icon(
                                            !model.showPassword
                                                ? FontAwesomeIcons.eyeSlash
                                                : FontAwesomeIcons.eye,
                                            color: ThemeService
                                                .currentColorScheme
                                                .blackColor[100],
                                          ),
                                        ),
                                      ),
                                      style: ThemeService.smallText,
                                    ),
                                  ),
                                  Visibility(
                                    visible: model.gotError(),
                                    child: MessageWidget(
                                      content: model.errorMessage,
                                      type: MessageType.danger,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ButtonWidget(
                              text: 'Login',
                              onPressed: model.login,
                              defineColor: Colors.white,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: model.createAccount,
                                  child: Text(
                                    'Create a new Account',
                                    style: ThemeService.normalText.copyWith(
                                      color: ThemeService
                                          .currentColorScheme.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: model.forgotPassword,
                                  child: Text(
                                    'Forgot my Password',
                                    style: ThemeService.normalText.copyWith(
                                      color: ThemeService
                                          .currentColorScheme.dangerColor,
                                      fontWeight: FontWeight.w400,
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
