import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/core/widgets/on_unfocus.dart';
import 'package:step_counter/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:step_counter/features/splash/presentation/view/splash_page.dart';
import 'package:step_counter/features/steps/presentation/bloc/step_bloc.dart';
import 'package:step_counter/features/user_details/presentation/cubit/user_details_cubit.dart';
import 'package:step_counter/core/logger/logger.dart';

void main() {
  // Disable logs in release builds
  Logger.instance.enabled = !kReleaseMode;
  Logger.instance.i('App starting. logging enabled=${Logger.instance.enabled}');

  runApp(const MyApp());
  Bloc.observer = BlockListener();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;

  
  
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    Logger.instance.d('SharedPreferences initialized');
  }

  @override
  Widget build(BuildContext context) {
    return OnUnFocusTap(
      child: BlocProvider(
        create: (context) =>
        SplashCubit()
          ..initialize(),
        child: BlocProvider(
          create: (context) => StepBloc(),
          child: BlocProvider(
            create: (context) => UserDetailsCubit()..initialize(),
            child: MaterialApp(
              title: 'Flutter Demo',
              themeMode: ThemeMode.dark,
              theme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Color(0xFF61FF59), brightness: Brightness.dark),
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

class BlockListener extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    Logger.instance.d('onChange: $change');
    super.onChange(bloc, change);
  }
}