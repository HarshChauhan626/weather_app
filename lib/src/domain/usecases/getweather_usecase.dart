import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/core/usecase/usecase.dart';
import 'package:weather_app/src/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/src/domain/entities/weather.dart';

class GetArticlesUseCase implements UseCase<ApiResult<Weather>, void> {
  final WeatherRepositoryImpl _weatherRepositoryImpl;

  GetArticlesUseCase(this._weatherRepositoryImpl);

  @override
  Future<ApiResult<Weather>> call(String city) {
    return _weatherRepositoryImpl.getWeather(city);
  }
}