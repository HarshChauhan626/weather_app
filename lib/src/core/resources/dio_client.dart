import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/src/core/utils/constants.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class DioClient {
  Dio? _dio;

  static header() => {"Content-Type": "application/json"};

  DioClient(){
    init();
  }

  Future<DioClient> init() async {
    print('Dio client init running');
    _dio = Dio(BaseOptions(baseUrl: Globals.kBaseUrl, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          // logger.i(
          //     "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
          //     "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          print("Request going is ${requestOptions.baseUrl}----${requestOptions.uri}--${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          // logger
          //     .i("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          // logger.i("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
      required Method method,
      Map<String, dynamic>? params}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post(url, data: params);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      print('Response coming is ${response.statusCode}');
      print("Response coming is ${response.data}");
      return response.data;

      // if (response.statusCode == 200) {
      //   return response;
      // } else if (response.statusCode == 401) {
      //   throw Exception("Unauthorized");
      // } else if (response.statusCode == 500) {
      //   throw Exception("Server Error");
      // } else {
      //   throw Exception("Something does wen't wrong");
      // }
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
