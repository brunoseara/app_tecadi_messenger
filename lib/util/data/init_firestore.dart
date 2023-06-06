import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../../model/usuario.dart';

class InitFirestore {
  Future<FirebaseFirestore> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios").doc("001").set({"nome": "Bruno", "idade": 36});
    return FirebaseFirestore.instance;
  }

  Usuario cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Usuario newUser = Usuario();

    auth.createUserWithEmailAndPassword(
            email: usuario.username!, password: usuario.password!)
        .then((firebaseUser){
          newUser.username = firebaseUser.user!.email;
          newUser.userId = firebaseUser.user!.uid;
          newUser.nome = firebaseUser.user!.displayName;

        })
        .catchError((onError) {
          print("ERRO " + onError.toString());
        });
    return newUser;
  }
}
