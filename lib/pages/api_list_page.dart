import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/cubit/generic_state.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:prueba_tecnica/pages/api_list/widgets/api_list_body.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';
import 'api_list/cubit/api_list_cubit.dart';

class ApiListPage extends StatelessWidget {
  const ApiListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Astronomy Picture of the Day',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: accentSecondary,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ApiListCubit()..initStream(),
          child: BlocListener<ApiListCubit, GenericState<List<ApodList>>>(
            listener: (context, state) {
              if (state is GenericError<List<ApodList>>) {
                Center(child: Text(state.errorMessage));
              }
            },
            child: BlocBuilder<ApiListCubit, GenericState<List<ApodList>>>(
              builder: (context, state) {
                if (state is GenericLoaded<List<ApodList>>) {
                  return ApiListBody(state.data!);
                }

                if (state is GenericLoading<List<ApodList>>) {
                  return const Center(
                    child: CircularProgressIndicator(color: textColor),
                  );
                }

                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
