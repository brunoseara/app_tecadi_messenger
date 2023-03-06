import 'package:realm/realm.dart';

@RealmModel()
class Mensagem{
  String? mensagem;
  DateTime? dataEnvio;
  bool? lida;
  DateTime? dataLeitura;
  bool? recebida;
  DateTime? dataRecebimento;  
}