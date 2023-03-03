import 'package:app_tecadi_messenger/view/TabConversas.dart';
import 'package:flutter/material.dart';

import 'TabContatos.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
        backgroundColor: const Color(0xff1270a2),
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
          children: const [
            DrawerHeader(
              duration: Duration(seconds: 5),
              decoration: BoxDecoration(
                color: Color(0xff1270a2),
                image: DecorationImage(
                    opacity: 0.2,
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877")),
              ),
              child: Column(children: [
                Text(
                  "Bruno Fillipe de Barros Seára",
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
                Row(children: [
                  Text(
                    "TI - ",
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                  Text(
                    "Analista de Sistemas",
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  )
                ])
              ]),
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
