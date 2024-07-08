import 'package:get_it/get_it.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);
