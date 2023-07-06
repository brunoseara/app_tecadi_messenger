
import 'package:realm/realm.dart';

import 'mensagem.dart';
@RealmModel()
class Conversa{
  String  userId = "";
  String codUser = "";
  String nome = "";
  String mensagem = "";
  String pathFoto = "";
  List<Mensagem>? mensagens;

  Conversa(this.userId, this.codUser, this.nome, this.mensagem, this.pathFoto);
}