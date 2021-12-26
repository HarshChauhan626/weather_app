import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/models/network_exceptions.dart';
import 'package:weather_app/services/dio_client.dart';
import 'package:weather_app/utils/globals.dart';
import '../models/api_result.dart';

class ApiRepository {
  DioClient? dioClient;

  ApiRepository() {
    dioClient = DioClient();
    dioClient!.init();
  }

  Future<ApiResult<Location>> locationSearch(String query) async {
    try {
      final locationResponse = await dioClient!.request(
          url: '/api/location/search',
          method: Method.GET,
          params: {'query': query});

      final locationJson = locationResponse as List;

      final location =
          Location.fromJson(locationJson.first as Map<String, dynamic>);
      return ApiResult.success(data: location);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<Weather>> getWeather(int locationId) async {
    try {
      final weatherResponse = await dioClient!
          .request(url: '/api/location/$locationId', method: Method.GET);

      final weatherJson = weatherResponse as Map<String, dynamic>;

      final weather = Weather.fromJson(weatherJson);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
