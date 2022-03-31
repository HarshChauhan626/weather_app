import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/src/config/di.dart';
import 'package:weather_app/src/core/resources/network_exceptions.dart';
import 'package:weather_app/src/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/src/domain/entities/weather.dart';
import 'package:weather_app/src/domain/repositories/weather_repository.dart';

part 'search_state.dart';

class SearchInfoCubit extends Cubit<SearchInfoState> {
  SearchInfoCubit() : super(SearchInfoState.initial());


  void setUpData() {
    // TODO Implement local data
  }

  void searchResult(String text,BuildContext context) async {
    emit(state.copyWith(searchInfoStatus: SearchInfoStatus.loading));
    final apiResult=await instance<WeatherRepositoryImpl>().getLocation(text);
    apiResult.when(success: (data){
      emit(state.copyWith(searchInfoStatus: SearchInfoStatus.success));
    }, failure: (NetworkExceptions exceptions){
      emit(state.copyWith(searchInfoStatus: SearchInfoStatus.error));
    });
  }
}
