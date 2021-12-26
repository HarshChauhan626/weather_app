// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// const _defaultConnectTimeout = Duration.millisecondsPerMinute;
// const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

// class DioClient {
//   final String baseUrl;

//   Dio _dio = Dio();

//   final List<Interceptor> interceptors;

//   DioClient(
//     this.baseUrl,
//     Dio dio, {
//     required this.interceptors,
//   }) {
//     _dio
//       ..options.baseUrl = baseUrl
//       ..options.connectTimeout = _defaultConnectTimeout
//       ..options.receiveTimeout = _defaultReceiveTimeout
//       ..httpClientAdapter
//       ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
//     if (interceptors.isNotEmpty ?? false) {
//       _dio.interceptors.addAll(interceptors);
//     }
//     if (kDebugMode) {
//       _dio.interceptors.add(LogInterceptor(
//           responseBody: true,
//           error: true,
//           requestHeader: false,
//           responseHeader: false,
//           request: false,
//           requestBody: false));
//     }
//   }

//   Future<dynamic> get(
//     String uri, {
//     required Map<String, dynamic> queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       var response = await _dio.get(
//         uri,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response.data;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<dynamic> post(
//     String uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     try {
//       var response = await _dio.post(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );
//       return response.data;
//     } on FormatException catch (_) {
//       throw FormatException("Unable to process the data");
//     } catch (e) {
//       throw e;
//     }
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/utils/globals.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class HttpService {
  Dio? _dio;

  static header() => {"Content-Type": "application/json"};

  Future<HttpService> init() async {
    _dio = Dio(BaseOptions(baseUrl: Globals().K_BASE_URL, headers: header()));
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

      // if (response.statusCode == 200) {
      //   return response;
      // } else if (response.statusCode == 401) {
      //   throw Exception("Unauthorized");
      // } else if (response.statusCode == 500) {
      //   throw Exception("Server Error");
      // } else {
      //   throw Exception("Something does wen't wrong");
      // }
    } on SocketException catch (e) {
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      throw Exception("Bad response format");
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception("Something wen't wrong");
    }
  }
}
