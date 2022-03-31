part of 'weather_info_cubit.dart';

enum WeatherInfoStatus { initial, success, error, loading }

extension WeatherInfoStatusX on WeatherInfoStatus {
  bool get isInitial => this == WeatherInfoStatus.initial;
  bool get isSuccess => this == WeatherInfoStatus.success;
  bool get isError => this == WeatherInfoStatus.error;
  bool get isLoading => this == WeatherInfoStatus.loading;
}

class WeatherInfoState extends Equatable {
  WeatherInfoState(
      {this.status, this.weather, this.forecastList, this.selectedIndex,this.selectedItemIndex});

  final Weather? weather;
  final WeatherInfoStatus? status;
  final List<Weather>? forecastList;
  final int? selectedIndex;
  final int? selectedItemIndex;

  factory WeatherInfoState.initial() {
    return WeatherInfoState(
        status: WeatherInfoStatus.initial,
        weather: Weather.empty(),
        forecastList: const [],
        selectedIndex: 0,
      selectedItemIndex: 0
    );
  }

  @override
  List<Object?> get props => [status, weather, forecastList,selectedIndex,selectedItemIndex];

  WeatherInfoState copyWith(
      {Weather? weather,
      WeatherInfoStatus? status,
      List<Weather>? forecastList,
      int? selectedIndex,
        int? selectedItemIndex
      }) {
    return WeatherInfoState(
        weather: weather ?? this.weather,
        status: status ?? this.status,
        forecastList: forecastList ?? this.forecastList,
        selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedItemIndex:selectedItemIndex??this.selectedItemIndex
    );
  }
}
