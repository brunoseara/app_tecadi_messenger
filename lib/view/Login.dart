import 'dart:io';
import 'package:app_tecadi_messenger/model/usuario.dart';
import 'package:app_tecadi_messenger/util/generic/generic.dart';
import 'package:app_tecadi_messenger/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../api/api_response.dart';
import '../api/login_api.dart';
import '../api/user_api.dart';
import '../util/generic/prefs.dart';
import '../util/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controllerUser =
      TextEditingController(text: "bruno.seara@tecadi.com.br");
  final TextEditingController _controllerPass =
      TextEditingController(text: "852088");
  final _formKey = GlobalKey<FormState>();

  Usuario usuario = Usuario();
  Usuario usr = Usuario();
  //service
  LoginApi api = LoginApi();
  UserApi apiUser = UserApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff1270A2), Color(0xff0C3F6B)])),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/image/logo/branco_vert.png",
                    width: 250,
                    height: 150,
                  ),
                ),
                Form(
                  key: _formKey,
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: _controllerUser,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "usuario@tecadi.com.br",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.account_circle)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerPass,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "senha",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.password_rounded)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateFields()) {
                          _executeLogin(/*_formKey*/);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1270A2),
                          foregroundColor: Colors.white,
                          elevation: 15,
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      child: const Text("Entrar"),
                    ),
                  )
                ])),
                Center(
                  child: GestureDetector(
                    child: const Text(
                      "Solicite seu acesso!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.5, 1.5),
                            blurRadius: 15.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.CADASTRO);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    String username = _controllerUser.text;
    String password = _controllerPass.text;
    String field = "";

    if (username.isNotEmpty && !username.contains("@")) {
      if (password.isNotEmpty) {
        usuario.username = username;
        usuario.password = password;
        field = "";
      } else {
        field = "senha";
      }
    } else {
      field = "usuário";
    }

    if (field.isEmpty) {
      Generic gen = Generic();
      gen.alert(
          context: context,
          titulo: "Ops! Algo deu errado!",
          conteudo:
              "O campo $field está vazio ou não foi prenchido corretamente.",
          buttonText: "Okay! Obrigado!");
      return false;
    }
    return true;
  }

  /// Realiza a autenticação
  _executeLogin(/*GlobalKey<FormState> formKey*/) async {
    /*if (formKey.currentState!.validate()) {
      try {
        
        ApiResponse response =
            await api.login(_controllerUser.text, _controllerPass.text);
        */
        WidgetsFlutterBinding.ensureInitialized();
          await Firebase.initializeApp();
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.signInWithEmailAndPassword(
            email: _controllerUser.text, 
            password: _controllerPass.text
            ).then((firebaseUser) async {
              
              FirebaseFirestore db = FirebaseFirestore.instance;
              DocumentSnapshot snapshot = await db.collection("usuarios").doc(firebaseUser.user!.uid).get();
              if(snapshot.data() != null){
                Usuario user = Usuario();
                // ignore: use_build_context_synchronously
                Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => Home(user.mapToUsuario(snapshot.data())),
                                ),
                              );
                //() => Navigator.pushReplacementNamed(context,Routes.HOME, arguments: user.mapToUsuario(snapshot.data()));
              }
            });
            /*
        if (response.isSuccess) {
          Map<String, dynamic> json = response.response;
          Prefs.setString(Prefs.token, json['access_token']);
          response = await api.getUser(_controllerUser.text);
        }
      } on HttpException catch (e) {
        print(e.message);
      } catch (i, _) {
        print(i.toString());
      }
    }*/
  }
}
