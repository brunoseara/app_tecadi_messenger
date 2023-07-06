import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TabContatos extends StatefulWidget {
  const TabContatos({super.key});

  @override
  State<TabContatos> createState() => _TabContatosState();
}

class _TabContatosState extends State<TabContatos> {
  late List<Usuario> listaContatos;

  Future<List<Usuario>?> _getContatos() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection("usuarios").get();

    List<Usuario>? listaUsuarios;

    for (DocumentSnapshot item in querySnapshot.docs) {
      dynamic dados = item.data();
      listaUsuarios!.add(Usuario.contato(
          userId: dados["userId"],
          nome: dados["nome"],
          departamento: dados["departamento"],
          funcao: dados["funcao"],
          pathFoto: dados['pathFoto']));
    }
    return (listaUsuarios);
  }

  @override
  Widget build(BuildContext context) {
    var children;
    return FutureBuilder(
        future: _getContatos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            children = ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                List<Usuario>? listaItens = snapshot.data;
                Usuario contato = listaItens![index];

                return ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: contato.pathFoto != null
                          ? NetworkImage(contato.pathFoto!)
                          : null),
                  title: Text(contato.nome!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text("${contato.departamento!} - ${contato.funcao}",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.grey)),
                );
              },
            );
          } else if (snapshot.hasError) {
            children = Center(
                child: Column(children: <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ]));
          } else {
            children = const Center(
              child: Column(children: <Widget>[
                Text("Carregando contatos"),
                CircularProgressIndicator()
              ]),
            );
          }
          return children;
        });
  }
}
