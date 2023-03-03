import 'package:app_tecadi_messenger/api/user_api.dart';

import 'api_response.dart';
import 'login_api.dart';

class Tecadi {
  Future<Map<String, dynamic>> consultaLoginTecadi(String user, String password) async {
    //service
    LoginApi api = LoginApi();
    UserApi apiUser = UserApi();
    final ApiResponse response = await api.login(user, password);

    if (response.isSuccess) {
      Map<String, dynamic> json = response.response;
      return json;
    }
    return {};
  }
}
