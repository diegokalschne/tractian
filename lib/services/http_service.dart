// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../models/errors/error_model.dart';
import 'internet_service.dart';

class HttpService {
  static const String BASE_API = 'https://fake-api.tractian.com';

  static Future get({
    required String route,
    Map? headers,
    Map? params,
  }) async {
    try {
      if (!await hasInternet()) {
        throw ErrorModel.internet();
      }

      final urlRequest = '$BASE_API$route';

      final dio = Dio();
      (dio.httpClientAdapter = IOHttpClientAdapter()).createHttpClient = () {
        HttpClient client = HttpClient();

        client.badCertificateCallback = (cert, host, port) => true;
        client.idleTimeout = const Duration(seconds: 60);
        client.connectionTimeout = const Duration(minutes: 2);

        return client;
      };

      final response = await dio.get(
        urlRequest,
        queryParameters: params?.cast(),
        options: Options(
          headers: headers?.cast(),
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ErrorModel.http('Erro ao realizar requisição $urlRequest - status code: ${response.statusCode}');
      }
    } on DioException catch (err) {
      throw ErrorModel('${err.message}', errorCode: err.response?.statusCode);
    } catch (_) {
      rethrow;
    }
  }
}
