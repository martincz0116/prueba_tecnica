import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/cubit/generic_state.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:prueba_tecnica/screens/api_list/widgets/api_list_body.dart';
import 'package:prueba_tecnica/screens/prefs/cubit/prefs_cubit.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';
import 'package:prueba_tecnica/widgets/drawer_widget.dart';
import 'package:prueba_tecnica/widgets/no_data_widget.dart';
import 'package:prueba_tecnica/widgets/reintentar_widget.dart';

class PrefsPage extends StatelessWidget {
  const PrefsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'My Prefs',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        iconTheme: const IconThemeData(color: textColor),
        backgroundColor: accentSecondary,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => PrefsCubit()..initStream(),
          child: BlocBuilder<PrefsCubit, GenericState<List<ApodList>>>(
            builder: (context, state) {
              if (state is GenericError<List<ApodList>>) {
                return ReintentarWidget(
                  onRetry: () => context.read<PrefsCubit>().initStream(),
                );
              }

              if (state is GenericLoaded<List<ApodList>>) {
                return ApiListBody(state.data!);
              }

              if (state is GenericLoading<List<ApodList>>) {
                return const Center(
                  child: CircularProgressIndicator(color: textColor),
                );
              }

              if (state is GenericEmpty<List<ApodList>>) {
                return NoDataWidget();
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
