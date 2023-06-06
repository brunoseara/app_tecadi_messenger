import 'package:app_tecadi_messenger/model/usuario.dart';
import 'package:app_tecadi_messenger/view/dialogo.dart';
import 'package:app_tecadi_messenger/view/cadastro.dart';
import 'package:app_tecadi_messenger/view/splash.dart';
import 'package:flutter/material.dart';

import '../../model/conversa.dart';
import '../../view/home.dart';
import '../../view/login.dart';

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
        return MaterialPageRoute(builder: (_) => const Splash());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => const Login());
      case HOME:
        Usuario usuario = settings.arguments as Usuario;
        return MaterialPageRoute(builder: (_) => Home(usuario));
      case CADASTRO:
        return MaterialPageRoute(builder: (_) => const Cadastro());
      case DIALOGO:
        Conversa conv = settings.arguments as Conversa;
        return MaterialPageRoute(builder: (_) => Dialogo(conv));
      default:
        return MaterialPageRoute(builder: (_) => const Splash());
    }
  }
}

