import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/features/presentation/login/bloc/login_bloc.dart';
import 'package:school_of_future/features/presentation/login/view/login_screen.dart';
import 'package:school_of_future/features/presentation/splash/bloc/splash_bloc.dart';
import 'package:school_of_future/features/presentation/splash/view/splash.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    print(settings.name.toString());
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SplashBloc(
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            child: const Splash(),
          ),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(getIt<IFlutterNavigator>(),
                getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            child: LoginScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text("Page Not Found"),
          ),
        );
    }
  }
}
