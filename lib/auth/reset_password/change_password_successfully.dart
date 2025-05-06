import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inomarket/auth/signin/signin_view.dart';
import 'package:inomarket/themes/theme_service.dart';

class PasswordChangedSuccessfullyView extends StatelessWidget {
  const PasswordChangedSuccessfullyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.check_circle,
            color: ThemeService.currentColorScheme.primaryColor,
            size: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'pass Changed',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await Get.offAll(
                const SigninView(
                  afterResetPassword: true,
                ),
              );
            },
            child: const Text('sign In'),
          )
        ]),
      ),
    );
  }
}
