import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/core/resources/dio_client.dart';
import 'package:weather_app/src/core/resources/network_exceptions.dart';
import 'package:weather_app/src/data/datasources/remote/api_service.dart';
import 'package:weather_app/src/data/models/location.dart';
import 'package:weather_app/src/data/models/weather.dart' hide Weather;
import 'package:weather_app/src/domain/entities/weather.dart';
import 'package:weather_app/src/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {

  ApiService apiService;

  WeatherRepositoryImpl(this.apiService);
  // @override
  // Future<ApiResult<Location>> getLocation(String query) async {
  //   try {
  //     final location = await apiService.locationSearch(query);
  //     return ApiResult.success(data: location);
  //   } catch (e) {
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }

  // @override
  // Future<ApiResult<Weather>> getWeather(String query) async {
  //   try {
  //     final location = await apiService.locationSearch(query);

  //     final weather = await apiService.getWeather(locationId);
  //     return ApiResult.success(data: weather);
  //   } catch (e) {
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }

  @override
  Future<ApiResult<Weather>> getWeather(String city) async {
    try {
      final locationResult = await getLocation(city);
      ApiResult<Weather> apiResult;
      Location? location;
      locationResult.when(
          success: (data) => {location = data},
          failure: (error) => {apiResult = ApiResult.failure(error: error)});
      final weather = await apiService.getWeather(location!.woeid);
      apiResult = ApiResult.success(
          data: Weather(
        temperature: weather.theTemp,
        location: location?.title ?? "",
        condition: weather.weatherStateAbbr.toCondition,
      ));
      return apiResult;
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<Location>> getLocation(String city) async {
    try {
      final location = await apiService.locationSearch(city);
      return ApiResult.success(data: location);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  // @override
  // Future<DataState<List<Article>>> getBreakingNewsArticles(
  //     ArticlesRequestParams params) async {
  //   try {
  //     final httpResponse = await _newsApiService.getBreakingNewsArticles(
  //       apiKey: params.apiKey,
  //       country: params.country,
  //       category: params.category,
  //       page: params.page,
  //       pageSize: params.pageSize,
  //     );

  //     if (httpResponse.response.statusCode == HttpStatus.ok) {
  //       return ApiResult.success(httpResponse.data.articles);
  //     }
  //     return ApiR(
  //       DioError(
  //         error: httpResponse.response.statusMessage,
  //         response: httpResponse.response,
  //         request: httpResponse.response.request,
  //         type: DioErrorType.RESPONSE,
  //       ),
  //     );
  //   } on DioError catch (e) {
  //     return DataFailed(e);
  //   }
  // }
}

extension on WeatherState {
  WeatherCondition get toCondition {
    switch (this) {
      case WeatherState.clear:
        return WeatherCondition.clear;
      case WeatherState.snow:
      case WeatherState.sleet:
      case WeatherState.hail:
        return WeatherCondition.snowy;
      case WeatherState.thunderstorm:
      case WeatherState.heavyRain:
      case WeatherState.lightRain:
      case WeatherState.showers:
        return WeatherCondition.rainy;
      case WeatherState.heavyCloud:
      case WeatherState.lightCloud:
        return WeatherCondition.cloudy;
      default:
        return WeatherCondition.unknown;
    }
  }
}
