import 'package:flutter/material.dart';

import '../model/usuario.dart';

class TabContatos extends StatefulWidget {
  const TabContatos({super.key});

  @override
  State<TabContatos> createState() => _TabContatosState();
}

class _TabContatosState extends State<TabContatos> {
  List<Usuario> listaContatos = [
    Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
    Usuario.contato("Luiz Poleza", "TI", "Gerente de TI",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Kalebe Silva", "TI", "Analista de suporte",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Alessandro Blenke", "Faturamento", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9"),
            Usuario.contato("Bruno Seára", "TI", "Analista de sistemas",
        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9")
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaContatos.length,
      itemBuilder: (context, index) {
        Usuario contato = listaContatos[index];
        return ListTile(
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
            );
      },
    );
  }
}