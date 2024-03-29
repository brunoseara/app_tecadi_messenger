import 'package:app_tecadi_messenger/util/data/init_firestore.dart';
import 'package:app_tecadi_messenger/util/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../model/conversa.dart';

class TabConversas extends StatefulWidget {
  const TabConversas({super.key});

  @override
  State<TabConversas> createState() => _TabConversasState();
}

class _TabConversasState extends State<TabConversas> {
  List<Conversa> listaConversas = [
    Conversa("123","000361", "Bruno Seára", "Olá, tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9")
  ];

  @override
  void initState() {
    
    //_getListaConversas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool delete = false;

    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, index) {
        Conversa conversa = listaConversas[index];
        return Dismissible(
            key: Key(conversa.codUser),
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.delete),
                ),
              ),
            ),
            dismissThresholds: const {DismissDirection.endToStart: 0.4},
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Row(children: [
                        Icon(Icons.delete),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Excluir a conversa?"))
                      ]),
                      content: const Text(
                          "Você tem certeza que deseja excluir esta conversa?"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancelar")),
                        TextButton(
                          onPressed: () async {
                            delete = true;
                            Navigator.of(context).pop(true);
                            final snackbarController =
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text("Conversa excluída"),
                                action: SnackBarAction(
                                    label: 'OK', onPressed: () => false),
                              ),
                            );
                            await snackbarController.closed;
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  },
                );
              }
              return false;
            },
            onDismissed: (_) {
              if (delete) {
                setState(() {
                  listaConversas.removeAt(index);
                });
              }
            },
            child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.DIALOGO,
                      arguments: listaConversas[index]);
                },
                contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(conversa.pathFoto)),
                title: Text(conversa.nome!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 7),
                        child: Icon(Icons.done_all, size: 18)),
                    Text(conversa.mensagem,
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Colors.grey))
                  ],
                )));
      },
    );
  }
  
  // Future<List<Conversa>> _getListaConversas() async {
  //   Conversa conv;
  //   List<Conversa> lista;
  //   User? user;

  //   WidgetsFlutterBinding.ensureInitialized();
  //     await Firebase.initializeApp();
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   user = auth.currentUser!;
  //   if(user.uid.toString() != null){
  //   }

  //   return(lista)

  // }
}
