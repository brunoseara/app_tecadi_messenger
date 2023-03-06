
import 'package:realm/realm.dart';

import 'Mensagem.dart';
@RealmModel()
class Conversa{

  String codUser = "";
  String nome = "";
  String mensagem = "";
  String pathFoto = "";
  List<Mensagem>? mensagens;

  Conversa(this.codUser, this.nome, this.mensagem, this.pathFoto);
}