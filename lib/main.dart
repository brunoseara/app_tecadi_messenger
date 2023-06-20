import 'dart:io';

import 'package:app_tecadi_messenger/util/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;

  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: const Color(0xff0C3F6B), secondary: Colors.white),
    ),
    title: "Tecadi Messenger",
    initialRoute: currentUser == null ? Routes.LOGIN : Routes.HOME,
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