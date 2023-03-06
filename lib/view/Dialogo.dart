import 'package:app_tecadi_messenger/model/Conversa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Dialogo extends StatefulWidget {
  final Conversa conversa;
  const Dialogo(this.conversa, {super.key});

  @override
  State<Dialogo> createState() => _DialogoState();
}

class _DialogoState extends State<Dialogo> {
  @override
  Widget build(BuildContext context) {
    
    TextEditingController _controllerSendMessage = TextEditingController();
    List<String> listaDialogo = [
      "Olá, tudo bem?",
      "Boa tarde, amigo!",
      "Tudo certo?",
      "Sim!",
      "Pode ver meu chamado?",
      "Então não está tudo certo!",
      "O que você acha que eu quero fazer com seu chamado? Vou fechá-lo, óbvio!",
      "Não, por favor! Não feche! Está tudo parado!",
      "O que está parado?",
      "Está tudo certo do lado do cliente",
      "Que lado?"
    ];

    Expanded dialogArea = Expanded(
        child: ListView.builder(
            itemCount: listaDialogo.length,
            itemBuilder: (context, index) {
              Alignment alinhamento = Alignment.centerRight;
              Color cor = const Color(0xff0c3f6b);
              TextStyle textStyle =
                  const TextStyle(fontSize: 16, color: Colors.white);

              if (index % 2 == 0) {
                cor = Colors.white;
                alinhamento = Alignment.centerLeft;
                textStyle = const TextStyle(fontSize: 16, color: Colors.black);
              }

              return Align(
                alignment: alinhamento,
                child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: cor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          listaDialogo[index],
                          style: textStyle,
                        )
                        // child: Row(
                        //   children: [
                        //     Container(

                        //       child: Text(
                        //       listaDialogo[index],
                        //       style: textStyle,
                        //       maxLines: 999999,
                        //     )),
                        //     const Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Icon(
                        //             Icons.done_all,
                        //             size: 12,
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(left: 5),
                        //             child: Text("12:05",
                        //                 style: TextStyle(fontSize: 11)),
                        //           )
                        //         ])
                        //   ],
                        // )),
                        )),
              );
            }));

    Container messageBox = Container(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextField(
              controller: _controllerSendMessage,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  hintText: "Digite sua mensagem...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.mic_sharp)),
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            if (_controllerSendMessage.text.isNotEmpty) {
              setState(() {
                listaDialogo.add(_controllerSendMessage.text);
                listaDialogo.skip(listaDialogo.length);
              });
            }
          },
          tooltip: "Enviar mensagem",
          backgroundColor: const Color(0xff0c3f6b),
          mini: true,
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        )
      ]),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Padding(
              padding: const EdgeInsets.only(top: 4, right: 12),
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                backgroundImage: NetworkImage(widget.conversa.pathFoto),
                maxRadius: 20,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.conversa.nome),
              Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 3),
                  child: const Text("Visto por último às 12:35",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: Colors.white60),
                    textAlign: TextAlign.left,
                  ))
            ],
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.camera_alt),
                  )))
        ]),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/dialogo/bg2.jpg"),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [dialogArea, messageBox]),
        )),
      ),
    );
  }
}
