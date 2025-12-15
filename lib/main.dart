import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/screens/api_list/cubit/api_list_cubit.dart';
import 'package:prueba_tecnica/screens/api_list/api_list_page.dart';
import 'package:prueba_tecnica/screens/prefs/prefs_page.dart';
import 'package:prueba_tecnica/services/service_locator.dart';
import 'package:prueba_tecnica/services/sqlflite_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  SqlfliteService().initDB();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/api-list',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const ApiListPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeInOutCirc,
                ).animate(animation),
                child: child,
              ),
        );
      },
    ),
    GoRoute(
      path: '/prefs',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const PrefsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
                opacity: CurveTween(
                  curve: Curves.easeInOutCirc,
                ).animate(animation),
                child: child,
              ),
        );
      },
    ),
  ],
  initialLocation: '/api-list',
);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApiListCubit>(create: (context) => ApiListCubit()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleWH: () => true,
      enableScaleText: () => true,
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
