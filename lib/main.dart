import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:step_counter/features/steps/presentation/bloc/step_bloc.dart';

import 'features/splash/presentation/view/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initialize(),
      child: BlocProvider(
        create: (context) => StepBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF61FF59), brightness: Brightness.dark),
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}




void showDeniedDialog(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
          'Please grant permission to access activity recognition.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Text('Settings'),
          ),
        ],
      );
    },
  );
}