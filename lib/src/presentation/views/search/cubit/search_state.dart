part of 'search_cubit.dart';

enum SearchInfoStatus { initial, success, error, loading }

extension SearchInfoStatusX on SearchInfoStatus {
  bool get isInitial => this == SearchInfoStatus.initial;
  bool get isSuccess => this == SearchInfoStatus.success;
  bool get isError => this == SearchInfoStatus.error;
  bool get isLoading => this == SearchInfoStatus.loading;
}

class SearchInfoState extends Equatable {
  SearchInfoState({this.searchInfoStatus, this.weatherMap});
  final SearchInfoStatus? searchInfoStatus;
  final List<Map<String, Weather>>? weatherMap;

  factory SearchInfoState.initial() {
    return SearchInfoState(
        searchInfoStatus: SearchInfoStatus.initial, weatherMap: []);
  }

  @override
  List<Object?> get props => [searchInfoStatus, weatherMap];

  SearchInfoState copyWith(
      {List<Map<String, Weather>>? weatherMap,
      SearchInfoStatus? searchInfoStatus}) {
    return SearchInfoState(
        weatherMap: weatherMap ?? this.weatherMap,
        searchInfoStatus: searchInfoStatus ?? this.searchInfoStatus);
  }
}
