import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/src/domain/entities/weather.dart';

part 'search_state.dart';

class SearchInfoCubit extends Cubit<SearchInfoState> {
  SearchInfoCubit() : super(SearchInfoState.initial());

  void setUpData() {
    // TODO Implement local data
  }

  void searchResult(String text) {}
}
