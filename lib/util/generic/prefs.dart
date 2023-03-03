import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const displayName = "displayName";
  static const token = "token";
  static const login = "login";
  static const tenantId = "tenantId";
  static const tokenFirebase = "tokenFirebase";
  static const permissions = "permissions";

  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? false;
  }

  static void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  static Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  static void setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  static Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  static void setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, s);
  }

  static Future<List<String>> getListString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key) ?? [];
  }

  static void setListString(String key, List<String> s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setStringList(key, s);
  }
}
