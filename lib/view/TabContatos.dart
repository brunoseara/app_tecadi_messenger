import 'package:flutter/material.dart';

import '../model/Usuario.dart';

class TabContatos extends StatefulWidget {
  const TabContatos({super.key});

  @override
  State<TabContatos> createState() => _TabContatosState();
}

class _TabContatosState extends State<TabContatos> {
  List<Usuario> listaContatos = [
    Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
    Usuario.contato("Luiz Poleza", "TI", "Gerente de TI",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Kalebe Silva", "TI", "Analista de suporte",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Alessandro Blenke", "Faturamento", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877")
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaContatos.length,
      itemBuilder: (context, index) {
        Usuario contato = listaContatos[index];
        return Dismissible(
            key: Key(contato.nome!),
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
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                bool delete = true;
                final snackbarController =
                    ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Conversa excluída"),
                    action: SnackBarAction(
                        label: 'Desfazer', onPressed: () => delete = false),
                  ),
                );
                await snackbarController.closed;
                return delete;
              }
            },
            onDismissed: (_) {
              setState(() {
                listaContatos.removeAt(index);
              });
            },
            child: ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(contato.pathFoto!)),
              title: Text(contato.nome!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text("${contato.departamento!} - ${contato.funcao}",
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.grey)),
            ));
      },
    );
  }
}