import 'dart:convert';

import '../util/generic/http_helper.dart';
import '../util/generic/prefs.dart';
import 'api_response.dart';
import 'api_routes.dart';

class UserApi {
  final HttpHelper _http = HttpHelper();

  Future<ApiResponse> getName(String user) async {
    ApiResponse response = await _http.executeGet(
      route: ApiRoutes.user.replaceAll("{id}", user),
    );

    if (response.isSuccess) {
      response.response = json.decode(response.response);
    }

    return response;
  }

  ///Retorna as empresas do usuário
  Future<ApiResponse> getCompanies() async {
    ApiResponse response = await _http.executeGet(
      route: ApiRoutes.userEmpresas,
    );
    if (response.isSuccess) {
      response.response = json.decode(response.response);
    }

    return response;
  }

  /// Resgata a foto de perfil do usuário
  Future<ApiResponse> putPicture(String base64) async {
    ApiResponse response = await _http.executePut(
        route: ApiRoutes.userFoto + await Prefs.getString(Prefs.login),
        body: base64);
    return response;
  }

  ///Retorna as empresas do usuário
  Future<ApiResponse> getPermissions() async {
    ApiResponse response = await _http.executeGet(
      route: ApiRoutes.userAcessos,
    );
    if (response.isSuccess) {
      response.response = json.decode(response.response);
    }

    return response;
  }
}
