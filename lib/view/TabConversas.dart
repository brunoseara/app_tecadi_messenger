import 'package:flutter/material.dart';

import '../model/Conversa.dart';


class TabConversas extends StatefulWidget {
  const TabConversas({super.key});

  @override
  State<TabConversas> createState() => _TabConversasState();
}

class _TabConversasState extends State<TabConversas> {

  List<Conversa> listaConversas = [
    Conversa("Bruno Seára", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
    Conversa("Bruno Seára", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
    Conversa("Bruno Seára", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
    Conversa("Bruno Seára", "Olá, tudo bem?", "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length,
      itemBuilder: (context, index){
        Conversa conversa = listaConversas[index];
        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.pathFoto)),
          title: Text(conversa.nome!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16 )),
          subtitle: Text(conversa.mensagem!, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.grey)),
        );
      },
    );
  }
}