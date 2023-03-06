import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:flutter/material.dart';

class ListaDrawer extends StatefulWidget {
  const ListaDrawer({super.key});

  @override
  State<ListaDrawer> createState() => _ListaDrawerState();
}

class _ListaDrawerState extends State<ListaDrawer> {
  @override
  Widget build(BuildContext context) {
        List<String> listaDrawer = [
      "E-mail: bruno.seara@tecadi.com.br",
      "Ramal: 1234",
      "Local: Adm 1º andar"
    ];

    return ListView.builder(
      itemCount: listaDrawer.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(listaDrawer[index]),
        );
      });
  }
}