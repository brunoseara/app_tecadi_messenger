import 'package:app_tecadi_messenger/model/usuario.dart';
import 'package:app_tecadi_messenger/view/tab_conversas.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../util/routes/routes.dart';
import 'tab_contatos.dart';

class Home extends StatefulWidget {
  final Usuario usuario;
  const Home(this.usuario, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String _loggedUser = ""; 

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    FirebaseAuth usr = FirebaseAuth.instance;
    if(usr.currentUser != null){
          _loggedUser = usr.currentUser!.uid.toString();
    }

  }

  late XFile? _img;

  Future _getImageFromDevice() async{
    XFile? selectedImage;
    ImagePicker img = ImagePicker();
    selectedImage = await img.pickImage(source: ImageSource.gallery);

    if(selectedImage != null){
      setState(() {
        //_avatar = selectedImage;
        _uploadImage(selectedImage!);
        _img = selectedImage;
      });
    }
  }

  Future _uploadImage(image) async {
    bool isLoading = false;
    FirebaseStorage storage = FirebaseStorage.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    Reference path = storage.ref();
    //auth.signInWithEmailAndPassword(email: "bruno.seara@tecadi.com.br", password: "852088");
    Reference file = path.child("profile").child("").child("profile.jpg");

      UploadTask task = file.putFile(image);
      task.snapshotEvents.listen((event) {
      });
  }

  _getImage(){
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usr = auth.currentUser;
    usr!.uid.toString();
    FirebaseStorage storage = FirebaseStorage.instance;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return GestureDetector(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 10, 12),
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        widget.usuario.pathFoto.toString()))),
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
                currentAccountPicture: Stack(
                  children: [
                  GestureDetector(
                    child: const CircleAvatar(
                    //backgroundImage: _avatar;
                    maxRadius: 100,
                  ),
                  onTap: (){showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                    Icon(Icons.question_answer),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10), child: Text("Selecionar foto"))
                                  ]),
                                  titlePadding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                  content: const Text("De onde você deseja selecionar uma mídia?"),
                                  actionsAlignment: MainAxisAlignment.end,
                                  actions: [
                                    TextButton(
                                      onPressed: () {_getImageFromDevice();},
                                      child: const Text("Galeria"),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text("Câmera"),
                                    )
                                  ],
                                );
                              });
                  },),
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
                            onPressed: () {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth.signOut();
                              Navigator.of(context).pop(false);
                              
                              },
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

