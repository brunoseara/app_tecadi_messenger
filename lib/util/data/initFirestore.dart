import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class initFirestore {
  Future<FirebaseFirestore> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    return FirebaseFirestore.instance;
  }

  void saveUsr() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios").doc("001").set({"nome": "Bruno", "idade": 36});
  }
}
