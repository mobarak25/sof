import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_of_future/app.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/utils/colors.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: bBlack.withOpacity(0.1),
  ));
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.release");
  } else if (kProfileMode) {
    await dotenv.load(fileName: ".env.profile");
  } else {
    await dotenv.load(fileName: ".env");
  }
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();
  await initGetStorage();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('bn', 'BD'), Locale('en', 'US')],
      path: 'lib/core/translations',
      fallbackLocale: const Locale('bn', 'BD'),
      saveLocale: true,
      startLocale: const Locale('bn', 'BD'),
      child: const MyApp(),
    ),
  );
}

Future<void> initGetStorage() async {
  await GetStorage.init();
}
