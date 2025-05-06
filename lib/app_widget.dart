import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inomarket/auth/signin/signin_view.dart';
import 'package:inomarket/home/home_view.dart';
import 'package:inomarket/themes/theme_service.dart';

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      theme: ThemeData(
        primarySwatch: ThemeService.currentColorScheme.primaryColor,
        fontFamily: 'Cairo',
      ),
      home: const HomeView(),
    );
  }
}
