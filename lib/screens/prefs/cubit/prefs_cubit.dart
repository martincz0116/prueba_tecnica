import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/cubit/generic_state.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:prueba_tecnica/services/sqlflite_service.dart';

class PrefsCubit extends Cubit<GenericState<List<ApodList>>> {
  PrefsCubit() : super(GenericInitial<List<ApodList>>());

  Future<void> initStream() async {
    try {
      emit(GenericLoading<List<ApodList>>());
      List<ApodList> data = await SqlfliteService().getRecords();

      if (data.isEmpty) {
        emit(GenericEmpty<List<ApodList>>());
        return;
      }

      emit(GenericLoaded<List<ApodList>>(data));
    } on Exception catch (e) {
      emit(GenericError<List<ApodList>>(e.toString()));
    }
  }
}
