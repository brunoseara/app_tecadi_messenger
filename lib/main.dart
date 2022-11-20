import 'package:app_tecadi_messenger/util/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: Color(0xff0C3F6B), secondary: Colors.white),
    ),
    title: "Tecadi Messenger",
    initialRoute: "/",
    onGenerateRoute: RouteGenerator().generateRoute,
    debugShowCheckedModeBanner: true,
  ));
}
