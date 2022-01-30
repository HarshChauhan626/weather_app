import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/core/usecase/usecase.dart';
import 'package:weather_app/src/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/src/domain/entities/weather.dart';

class GetWeatherUseCase implements UseCase<ApiResult<Weather>, String> {
  final WeatherRepositoryImpl _weatherRepositoryImpl;

  GetWeatherUseCase(this._weatherRepositoryImpl);

  @override
  Future<ApiResult<Weather>> call({required String params}) {
    return _weatherRepositoryImpl.getWeather(params);
  }
}
