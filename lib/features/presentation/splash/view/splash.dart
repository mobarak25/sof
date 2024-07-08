import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/features/presentation/splash/bloc/splash_bloc.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return Body(
          isFullScreen: true,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(splashBg),
                fit: BoxFit.fill,
              ),
            ),
          ),
        );
      },
    );
  }
}
