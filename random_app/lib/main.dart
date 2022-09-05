import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:random_app/localizations.dart';
import 'package:random_app/random/random_password.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppLocalizations(),
      locale: Get.deviceLocale,
      home: RandomPasswordPage(),
    );
  }
}
