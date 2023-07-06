import 'dart:ui';

class Usuario{
    String? userId;
    String? codTotvs;
    String? username;
    String? password;
    String? nome;
    String? status;
    String? pathFoto;
    Image?  foto;
    String? departamento;
    String? funcao;
    String? mensagemStatus;
    String? ramal;

    Usuario();
    Usuario.contato({required this.userId, required this.nome,  this.departamento, this.funcao, this.pathFoto});

    Usuario getUsuario(String email){
    Usuario usr = Usuario();
      usr.userId = "000361";
      usr.codTotvs = "000361";
      usr.nome = "Bruno Fillipe de Barros Seára";
      usr.departamento = "TI";
      usr.funcao = "Analista de Sistemas";
      usr.pathFoto = "https://firebasestorage.googleapis.com/v0/b/tecadi-messenger-b2576.appspot.com/o/IMG_2142.JPG?alt=media&token=5d109487-3c7c-42a9-b734-9f0571af7bf9";
      usr.username = "bruno.seara@tecadi.com.br";
      return usr;
    }

  Usuario mapToUsuario(var snapshot) {   
      Usuario usr = Usuario();
      //usr.userId = uuid;
      usr.codTotvs = snapshot["codTotvs"];
      usr.username = snapshot["username"];
      usr.nome = snapshot["nome"];
      usr.status = snapshot["status"];
      usr.pathFoto = snapshot["pathFoto"];
      usr.foto = snapshot["foto"];
      usr.departamento = snapshot["departamento"];
      usr.funcao = snapshot["funcao"];
      usr.mensagemStatus = snapshot["mensagemStatus"];
      usr.ramal = snapshot["ramal"];
      return usr;
    }

    // Usuario mapToUsuario(DocumentSnapshot<Usuario> map){
    //   Usuario usr = Usuario();
    //   usr.codTotvs = map["codTotvs"];
    //   usr.username = map["username"];
    //   usr.nome = map["nome"];
    //   usr.status = map["status"];
    //   usr.pathFoto = map["pathFoto"];
    //   usr.foto = map["foto"];
    //   usr.departamento = map["departamento"];
    //   usr.funcao = map["funcao"];
    //   usr.mensagemStatus = map["mensagemStatus"];
    //   usr.ramal = map["ramal"];
    //   return usr;
    // }
}
