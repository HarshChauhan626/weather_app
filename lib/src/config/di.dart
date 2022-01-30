import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/src/data/datasources/local/local_storage_service.dart';
import 'package:weather_app/src/data/datasources/remote/api_service.dart';
import 'package:weather_app/src/data/network_info.dart';
import 'package:weather_app/src/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/src/domain/usecases/getweather_usecase.dart';
import 'package:weather_app/src/presentation/cubits/weather_info_cubit.dart';
import 'package:weather_app/src/presentation/views/search/cubit/search_cubit.dart';

final instance = GetIt.instance;

Future<void> initModule() async {
  instance
      .registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  instance.registerLazySingleton<ApiService>(() => ApiService());
  instance.registerLazySingleton<WeatherRepositoryImpl>(
      () => WeatherRepositoryImpl(instance()));
  instance
      .registerFactory<GetWeatherUseCase>(() => GetWeatherUseCase(instance()));
  instance
      .registerFactory<WeatherInfoCubit>(() => WeatherInfoCubit(instance()));
  instance.registerFactory<SearchInfoCubit>(() => SearchInfoCubit());
  instance.registerFactory<NetworkInfoImpl>(
      () => NetworkInfoImpl(DataConnectionChecker()));
}

void resetModule() {
  instance.reset(dispose: true);
}
