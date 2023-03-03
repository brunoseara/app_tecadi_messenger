

class ApiRoutes {
  static const _prefix = '/app';

  /// API relacionado a usuário
  static const String login = '$_prefix/api/oauth2/v1/token';
  static const String user = '$_prefix/api/framework/v1/users/{id}';
  static const String userEmpresas = '$_prefix/usuario/empresa';
  static const String userFoto = '$_prefix/usuario/foto/';
  static const String userAcessos = '$_prefix/usuario/acessos';

}
