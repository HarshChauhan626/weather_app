import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/src/core/resources/api_result.dart';
import 'package:weather_app/src/core/resources/network_exceptions.dart';
import 'package:weather_app/src/domain/entities/weather.dart';
import 'package:weather_app/src/domain/usecases/getweather_usecase.dart';

part 'weather_info_state.dart';

class WeatherInfoCubit extends Cubit<WeatherInfoState> {
  final GetWeatherUseCase _getWeatherUseCase;

  WeatherInfoCubit(this._getWeatherUseCase) : super(WeatherInfoState.initial());


  void tabChanged(int indexVal) {
    print("Tab changed called");
    emit(state.copyWith(selectedIndex: indexVal));
  }

  void listItemClicked(int indexVal) {
    print("Tab changed called");
    emit(state.copyWith(selectedItemIndex: indexVal));
  }


  Future<void> initializeData() async {
    emit(state.copyWith(status: WeatherInfoStatus.loading));
    final ApiResult dataState = await _getWeatherUseCase(params: "Delhi");
    Weather? weather;
    dataState.when(success: (data) {
      emit(state.copyWith(weather: data, status: WeatherInfoStatus.success));
    }, failure: (NetworkExceptions exceptions) {
      print(exceptions.toString());
      emit(state.copyWith(status: WeatherInfoStatus.error));
      print('OOps something went wrong');
    });
  }

  void getData(String city) async {
    emit(state.copyWith(status: WeatherInfoStatus.loading));
    final ApiResult dataState = await _getWeatherUseCase(params: city);
    Weather? weather;
    dataState.when(success: (data) {
      emit(state.copyWith(weather: data, status: WeatherInfoStatus.success));
    }, failure: (NetworkExceptions exceptions) {
      print(exceptions.toString());
      emit(state.copyWith(status: WeatherInfoStatus.error));
      print('OOps something went wrong');
    });
  }
}
