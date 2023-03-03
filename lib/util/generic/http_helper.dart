import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_tecadi_messenger/util/generic/prefs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import '../../api/api_config.dart';
import '../../api/api_response.dart';

class HttpHelper {
  static const timeOut = 5;
  static const trysRequest = 4;

  Future<String> getToken() async {
    final String token = await Prefs.getString(Prefs.token);
    return token;
  }

  Future<String> getTenantId() async {
    final String tenantId = await Prefs.getString(Prefs.tenantId);
    return tenantId;
  }

  Future<Map<String, String>> getHeader() async {
    final token = await getToken();
    final tenantId = await getTenantId();

    return {
      "Authorization": "Bearer $token",
      "tenantId": tenantId,
      "Accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
      "Connection": "keep-alive",
      "x-erp-module": "WMS",
    };
  }

  /// Executa requisição de verbose POST
  Future<ApiResponse> executePost({
    body,
    String route = '',
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _executeRequest(
      "POST",
      body: body,
      queryParameters: queryParameters,
      route: route,
    );
  }

  /// Executa requisições de verbose PUT
  Future<ApiResponse> executePut({
    body,
    String route = '',
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _executeRequest(
      "PUT",
      body: body,
      route: route,
    );
  }

  /// Realiza requisição de verbose GET
  Future<ApiResponse> executeGet({
    String route = '',
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _executeRequest(
      "GET",
      queryParameters: queryParameters,
      route: route,
    );
  }

  /// Executa requisições de verbose Delete
  Future<ApiResponse> executeDelete({
    body,
    String route = '',
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _executeRequest(
      "DELETE",
      body: body,
      route: route,
    );
  }

  //Executa o request
  _executeRequest(
    String verbose, {
    body,
    String route = '',
    Map<String, dynamic>? queryParameters,
  }) async {
    bool hasResponse = false;

    //URL de acesso
    final url = Uri.https(
      ApiConfig.authority,
      route,
      queryParameters,
    );

    //Header
    Map<String, String> headers = await getHeader();

    var response;

    for (var i = 0; i <= trysRequest; i++) {
      try {
        //Verifica o método HTTP que deve ser invocado
        switch (verbose) {
          case "GET":
            response = await http.get(url, headers: headers).timeout(
                  const Duration(minutes: timeOut),
                );
            break;

          case "PUT":
            response =
                await http.put(url, body: body, headers: headers).timeout(
                      const Duration(minutes: timeOut),
                    );
            break;

          case "POST":
            response =
                await http.post(url, body: body, headers: headers).timeout(
                      const Duration(minutes: timeOut),
                    );
            break;

          case "DELETE":
            response =
                await http.delete(url, body: body, headers: headers).timeout(
                      const Duration(minutes: timeOut),
                    );
            break;
        }
      } catch (_) {
        //Verifica o problema que houve durante o request na classe http
        print("Tentar novamente");
        //Verifica se o wifi caiu, caso sim deve aguardar 3 segundos antes de tentar novamente
        bool hasNetwork = await isNetworkOn();
        if (!hasNetwork) {
          await Future.delayed(
            const Duration(
              seconds: 8,
            ),
          );

          //Verifico novamente se não há internet, caso não tenha voltado depois de 5 segundos, lança exceção.
          bool hasNetwork = await isNetworkOn();
          if (!hasNetwork) {
            throw const HttpException('Você está offline.');
          }
        }
      }

      if (response != null) {
        //Verifica o código de resposta http, se retornar true significa que houve êxito
        //se retornar falso, indica que pode tentar o request novamente
        //se lançar exceção, não pode tentar e nem continuar
        if (_verifiyResponse(response)) {
          hasResponse = true;
          break;
        }
      }
    }

    //Se não houver êxito na resposta, lança exceção
    if (!hasResponse) {
      throw const HttpException(
          'O servidor não pode atender esta requisição no momento, aguarde alguns segundos e tente novamente.');
    }

    return ApiResponse(true, response.body);
  }

  /// Verifica a respsota requisição
  _verifiyResponse(response) {
    print("Código de resposta HTTP > ${response.statusCode}");

    if (response.statusCode == 503) {
      return false;
    } else if (response.statusCode == 500) {
      throw const HttpException(
          'Ocorreu um erro interno no servidor, tente aguardar alguns segundos ou fechar e abrir o aplicativo. Se o problema persistir abra um chamado no setor de TI.');
    } else if (response.statusCode > 500) {
      throw HttpException(json
          .decode(response.body)
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim());
    } else if (response.statusCode >= 400) {
      if (response.statusCode == 400) {
        final message = json.decode(response.body);
        throw HttpException(message['messageError']);
      }
      return false;
    }

    return true;
  }

  Future<bool> isNetworkOn() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
