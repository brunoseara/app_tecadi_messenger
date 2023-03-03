import 'package:flutter/material.dart';

class Generic {
  void alert(
      {required BuildContext context,
      required String titulo,
      required String conteudo,
      required String buttonText}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Icon(Icons.warning),
              Padding(
                  padding: const EdgeInsets.only(left: 10), child: Text(titulo))
            ]),
            titlePadding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            content: Text(conteudo),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(buttonText),
              )
            ],
          );
        });
  }
}
