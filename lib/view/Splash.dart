import 'dart:ui';
import 'package:app_tecadi_messenger/util/data/initFirestore.dart';
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
    initFirestore().initialize();
    initFirestore().saveUsr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff0C3F6B),
        padding: EdgeInsets.all(60),
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
