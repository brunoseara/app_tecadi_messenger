import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

@RealmModel()
class Usuario{
    @PrimaryKey()
    String? userId;
    String? codTotvs;
    String? username;
    String? password;
    String? nome;
    String? status;
    String? pathFoto;
    Image? foto;
    String? departamento;
    String? funcao;
    String? mensagemStatus;
    String? ramal;

    Usuario();
    Usuario.contato(this.nome,  this.departamento, this.funcao ,this.pathFoto);

    Usuario getUsuario(String email){
      Usuario usr = Usuario();
      usr.userId = "000361";
      usr.codTotvs = "000361";
      usr.nome = "Bruno Fillipe de Barros Seára";
      usr.departamento = "TI";
      usr.funcao = "Analista de Sistemas";
      usr.pathFoto = "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-0.appspot.com/o/profile_pic.jpg?alt=media&token=876b4e04-6858-4bd3-94b1-10a30b83c877";
      usr.username = email;
      return usr;
    }
}
