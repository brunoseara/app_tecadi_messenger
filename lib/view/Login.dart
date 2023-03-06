import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:app_tecadi_messenger/util/generic/Generic.dart';
import 'package:flutter/material.dart';

import '../util/routes/routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final TextEditingController _controllerUser = TextEditingController(text: "bruno.seara@tecadi.com.br");
  final TextEditingController _controllerPass = TextEditingController(text: "123456");
  
  Usuario usuario = Usuario();
  
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
                      if(_validateFields()){
                        Navigator.pushReplacementNamed(context, Routes.HOME, arguments: usuario.getUsuario(_controllerUser.text));
                      };
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
                ),
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

    if (username.isNotEmpty && username.contains("@")) {
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

    if (field.isNotEmpty) {
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

}
