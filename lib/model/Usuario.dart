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

}
