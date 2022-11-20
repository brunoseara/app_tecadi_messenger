import 'package:app_tecadi_messenger/view/Splash.dart';
import 'package:flutter/material.dart';

import '../../view/Home.dart';
import '../../view/Login.dart';

class RouteGenerator {
  static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String HOME = "/home";

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(builder: (_) => Splash());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
      case HOME:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}
