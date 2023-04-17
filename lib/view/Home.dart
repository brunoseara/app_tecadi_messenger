import 'dart:html';

import 'package:app_tecadi_messenger/model/Usuario.dart';
import 'package:app_tecadi_messenger/view/TabConversas.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../util/routes/routes.dart';
import 'TabContatos.dart';

class Home extends StatefulWidget {
  final Usuario usuario;
  const Home(this.usuario, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  late XFile? _avatar;

  Future _getImageFromDevice() async{
    XFile? selectedImage;
    ImagePicker img = ImagePicker();
    selectedImage = await img.pickImage(source: ImageSource.gallery);

    if(selectedImage != null){
      setState(() {
        //_avatar = selectedImage;
        _uploadImage(selectedImage!);
      });
    }
  }

  Future _uploadImage(image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference path = storage.ref();
    Reference file = path.child("profile").child("profile_pic.jpg");
    file.putFile(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return GestureDetector(
            child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 10, 12),
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"))),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: const Text("Tecadi Messenger"),
        backgroundColor: const Color(0xff0c3f6b),
        bottom: TabBar(
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          controller: _tabController,
          labelStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          tabs: const [
            Tab(
              text: "Conversas",
            ),
            Tab(
              text: "Contatos",
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: Stack(children: [
                  GestureDetector(child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877"),
                    maxRadius: 100,
                  ),
                  onTap: (){},),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(7.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: Colors.green,
                            border: Border.all(width: 2, color: Colors.white)),
                      )),
                ]),
                accountName: Text(
                  widget.usuario.nome.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                accountEmail: Text(widget.usuario.username.toString())),
            ListTile(
              trailing: const Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop(false);
              },
              title: const Text(
                "Página principal",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              trailing: const Icon(Icons.info),
              onTap: () {},
              title: const Text(
                "Sobre",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              trailing: const Icon(Icons.exit_to_app),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Row(children: [
                        Icon(Icons.exit_to_app),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Sair do app?"))
                      ]),
                      content: const Text(
                          "Você tem certeza que deseja abandonar o app?"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancelar")),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            Navigator.pushReplacementNamed(
                                context, Routes.LOGIN);
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  },
                );

                //todo aqui logout
              },
              title: const Text(
                "Sair",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: const [TabConversas(), TabContatos()]),
    );
  }
}

