// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: always_use_package_imports, prefer_const_constructors, cascade_invocations, comment_references, require_trailing_commas

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_quill/flutter_quill.dart';
import 'package:get_it/get_it.dart' as i1;
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart' as i2;
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/flutter_navigator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/network_info/network_info.dart';
import 'package:school_of_future/features/data/repositories/api_repo_impl.dart';
import 'package:school_of_future/features/data/repositories/local_storage_repo_impl.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/get_location_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// initializes the registration of provided dependencies inside of [GetIt]

i1.GetIt $initGetIt(i1.GetIt sl,
    {String? environment, i2.EnvironmentFilter? environmentFilter}) {
  final gh = i2.GetItHelper(sl, environment, environmentFilter);

  gh.lazySingleton<IFlutterNavigator>(() => FlutterNavigator());

  gh.lazySingleton(() => GetStorage());
  gh.lazySingleton(() => ImagePicker());
  gh.lazySingleton(() => PanelController());
  gh.lazySingleton(() => QuillController.basic());

  gh.lazySingleton<LocalStorageRepo>(() => LocalStorageRepoImpl(sl()));
  gh.lazySingleton(() => InternetConnectionChecker());
  gh.lazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  gh.lazySingleton<ApiRepo>(() => ApiRepoImpl(sl()));
  gh.lazySingleton<GetLocationRepo>(() => GetLocationRepoImpl());
  gh.lazySingleton<FilePickerRepo>(() => FilePickerRepoImpl());
  gh.lazySingleton(() => FilterSidebarBloc(getIt<ApiRepo>()));

  return sl;
}
