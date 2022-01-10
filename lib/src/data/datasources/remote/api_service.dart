import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/core/resources/dio_client.dart';
import 'package:weather_app/src/core/resources/network_exceptions.dart';
import 'package:weather_app/src/data/datasources/remote/base_api_service.dart';
import 'package:weather_app/src/data/models/models.dart';

class ApiService extends BaseApiService {
  DioClient? dioClient;

  ApiRepository() {
    dioClient = DioClient();
    dioClient!.init();
  }

  @override
  Future<Location> locationSearch(String query) async {
    // try {
    //   final locationResponse = await dioClient!.request(
    //       url: '/api/location/search',
    //       method: Method.GET,
    //       params: {'query': query});

    //   final locationJson = locationResponse as List;

    //   final location =
    //       Location.fromJson(locationJson.first as Map<String, dynamic>);
    //   return ApiResult.success(data: location);
    // } catch (e) {
    //   return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    // }
    final locationResponse = await dioClient!.request(
        url: '/api/location/search',
        method: Method.GET,
        params: {'query': query});

    final locationJson = locationResponse as List;

    final location =
        Location.fromJson(locationJson.first as Map<String, dynamic>);

    return location;
  }

  @override
  Future<Weather> getWeather(int locationId) async {
    // try {
    //   final weatherResponse = await dioClient!
    //       .request(url: '/api/location/$locationId', method: Method.GET);

    //   final weatherJson = weatherResponse as Map<String, dynamic>;

    //   final weather = Weather.fromJson(weatherJson);

    //   return ApiResult.success(data: weather);
    // } catch (e) {
    //   return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    // }
    final weatherResponse = await dioClient!
        .request(url: '/api/location/$locationId', method: Method.GET);

    final weatherJson = weatherResponse as Map<String, dynamic>;

    final weather = Weather.fromJson(weatherJson);

    return weather;
  }
}
