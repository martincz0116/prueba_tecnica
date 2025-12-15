import 'package:get_it/get_it.dart';
import 'package:prueba_tecnica/screens/api_list/cubit/api_list_cubit.dart';
import 'package:prueba_tecnica/screens/prefs/cubit/prefs_cubit.dart';
import 'package:prueba_tecnica/services/api_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton(ApiService());
  getIt.registerSingleton(ApiListCubit());
  getIt.registerSingleton(PrefsCubit());
}
