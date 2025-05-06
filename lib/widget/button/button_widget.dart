import 'package:inomarket/themes/theme_service.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Widget? child;
  final bool dissabled;
  final IconData? icon;
  final void Function() onPressed;
  final Color? defineColor;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.child,
    this.icon,
    this.dissabled = false,
    this.defineColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              elevation: 10,
              shadowColor: Colors.black.withOpacity(1))
          .merge(
        ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (dissabled) {
              return ThemeService.currentColorScheme.backgroundColor[300];
            }
            if (states.contains(MaterialState.pressed)) {
              return ThemeService.currentColorScheme.primaryColor[200];
            }
            return ThemeService.currentColorScheme.primaryColor;
          }),
        ),
      ),
      onPressed: dissabled ? () {} : onPressed,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: defineColor,
                    ),
                  ),
                ],
              )),
    );
  }
}
