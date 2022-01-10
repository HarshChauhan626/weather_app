import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/data/models/models.dart';

abstract class BaseApiService {
  Future<Location> locationSearch(String query);
  Future<Weather> getWeather(int locationId);
}
