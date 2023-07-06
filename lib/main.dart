import 'dart:io';
import 'package:app_tecadi_messenger/util/routes/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: const Color(0xff0C3F6B), secondary: Colors.white),
    ),
    title: "Tecadi Messenger",
    initialRoute: Routes.SPLASH,
    onGenerateRoute: Routes().generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}