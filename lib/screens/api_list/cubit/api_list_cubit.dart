import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/cubit/generic_state.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:prueba_tecnica/services/api_service.dart';
import 'package:prueba_tecnica/services/service_locator.dart';

class ApiListCubit extends Cubit<GenericState<List<ApodList>>> {
  ApiListCubit() : super(GenericInitial<List<ApodList>>());
  final ApiService _apiService = getIt();

  Future<List<ApodList>> getApiList() async {
    List<ApodList> data = await _apiService.getApodList();
    return data;
  }

  Future<void> initStream() async {
    try {
      emit(GenericLoading<List<ApodList>>());
      List<ApodList> data = await _apiService.getApodList();
      emit(GenericLoaded<List<ApodList>>(data));
    } on Exception catch (e) {
      emit(GenericError<List<ApodList>>(e.toString()));
    }
  }
}
