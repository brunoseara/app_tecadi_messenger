import 'dart:async';
import 'package:app_tecadi_messenger/util/data/InitFirestore.dart';
import 'package:app_tecadi_messenger/util/routes/routes.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    InitFirestore().initialize();
    Timer(const Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, Routes.LOGIN));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff1270A2), Color(0xff0C3F6B)])),
        padding: const EdgeInsets.all(60),
        child: Center(
          child: Image.asset(
            "assets/image/logo/branco_vert.png",
            width: 180,
          ),
        ),
      ),
    );
  }
}
