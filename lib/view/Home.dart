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
        title: Row(children: [
          GestureDetector(
              child: const Icon(Icons.account_circle_rounded, size: 30),
              onTap: () {}),
          const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Tecadi Messenger"))
        ]),
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
      body: TabBarView(
          controller: _tabController,
          children: [TabConversas(), TabContatos()]),
    );
  }
}
