import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../error/presentation/view/error_page.dart';
import '../../../steps/presentation/bloc/step_bloc.dart';
import '../../../steps/presentation/view/step_page.dart';
import '../cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            context.read<StepBloc>().add(StepRecord(step: 0));
            Future.delayed(const Duration(milliseconds: 900), () {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StepPage(),
                  ),
                );
              }
            });
          } else if (state is SplashError) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ErrorPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Image.asset(
                "assets/app_icon/app_icon.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
