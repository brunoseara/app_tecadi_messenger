import 'package:app_tecadi_messenger/view/Splash.dart';
import 'package:flutter/material.dart';

import '../../view/Home.dart';
import '../../view/Login.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Splash());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}
