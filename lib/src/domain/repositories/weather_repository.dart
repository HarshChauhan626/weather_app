import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/domain/entities/weather.dart';

abstract class WeatherRepository {
  // Future<ApiResult<Location>> getLocation(String query);
  Future<ApiResult<Weather>> getWeather(String query);
}
