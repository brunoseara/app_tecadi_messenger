import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:app_tecadi_messenger/util/data/InitFirestore.dart';
import 'package:flutter/material.dart';

import '../util/generic/Generic.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  Usuario usuario = Usuario();
  TextEditingController _controllerUser = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Solicitar cadastro"),
        ),
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
                  Center(
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(32),
                        child: Icon(Icons.account_box,
                            size: 100, color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: _controllerUser,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Usuário TOTVS",
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
                          hintText: "Senha TOTVS",
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
                        if(validateFields()){
                          InitFirestore firestore = InitFirestore();
                          usuario = firestore.cadastrarUsuario(usuario);
                        };
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1270A2),
                          foregroundColor: Colors.white,
                          elevation: 15,
                          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      child: const Text("Solicitar cadastro"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  bool validateFields() {
    String username = _controllerUser.text;
    String password = _controllerPass.text;
    String field = "";

    if (username.isNotEmpty) {
      if (password.isNotEmpty) {
        usuario.username = username;
        usuario.password = password;
        return true;
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
