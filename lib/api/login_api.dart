import 'dart:convert';

import '../util/generic/http_helper.dart';
import 'api_response.dart';
import 'api_routes.dart';


class LoginApi {
  final HttpHelper _http = HttpHelper();

  Future<ApiResponse> login(String user, String password) async {
    final queryParams = {
      "username": user,
      "password": password,
      "grant_type": "password"
    };

    ApiResponse response = await _http.executePost(
      route: ApiRoutes.login,
      queryParameters: queryParams,
    );

    if (response.isSuccess) {
      response.response = json.decode(response.response);
    }

    return response;
  }
}
