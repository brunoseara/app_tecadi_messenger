import 'dart:async';
import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:app_tecadi_messenger/util/data/init_firestore.dart';
import 'package:app_tecadi_messenger/util/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() async {
    super.initState();
      WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser = auth.currentUser;
  if(currentUser != null){
      Usuario usuario = Usuario();
      usuario.getUsuario(auth.currentUser!.email.toString());
  }
    Timer(const Duration(seconds: 5), () {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        Navigator.pushReplacementNamed(context, Routes.LOGIN);
      } else {
        Navigator.pushReplacementNamed(context, Routes.HOME);
      }
    });
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
