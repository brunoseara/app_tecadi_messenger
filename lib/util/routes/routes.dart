import 'package:app_tecadi_messenger/model/Conversa.dart';
import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:app_tecadi_messenger/view/Dialogo.dart';
import 'package:app_tecadi_messenger/view/Cadastro.dart';
import 'package:app_tecadi_messenger/view/Splash.dart';
import 'package:flutter/material.dart';

import '../../view/Home.dart';
import '../../view/Login.dart';

class Routes {
  static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String HOME = "/home";
  static const String CADASTRO = "/cadastro";
  static const String DIALOGO = "/dialogo";

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => Splash());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
      case HOME:
        Usuario usuario = settings.arguments as Usuario;
        return MaterialPageRoute(builder: (_) => Home(usuario));
      case CADASTRO:
        return MaterialPageRoute(builder: (_) => Cadastro());
      case DIALOGO:
        Conversa conversa = settings.arguments as Conversa;
        return MaterialPageRoute(builder: (_) => Dialogo(conversa));
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}

