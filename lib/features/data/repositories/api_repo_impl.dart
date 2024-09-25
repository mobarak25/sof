import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:school_of_future/core/error/custom_error.dart';
import 'package:school_of_future/core/error/custom_exception.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/network_info/network_info.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_gateway_base.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

const String noInternetConnection = 'No Internet Connection';

@LazySingleton(as: ApiRepo)
class ApiRepoImpl extends RemoteGatewayBase implements ApiRepo {
  const ApiRepoImpl(this.networkInfo);

  final NetworkInfo networkInfo;

  @override
  Future<T?> post<T>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await postMethod<T, void>(
          endpoint: endpoint, data: body, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> put<T>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await putMethod<T, void>(
          endpoint: endpoint, data: body, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> postForList<T, K>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data =
          await postMethod<T, K>(endpoint: endpoint, data: body, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> get<T>({required String endpoint, body, String? token}) async {
    dynamic data;
    if (await networkInfo.isConnected) {
      data = await getMethod<T, void>(endpoint: endpoint);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> getForList<T, K>(
      {required String endpoint, dynamic body, String? token}) async {
    dynamic data;
    if (await networkInfo.isConnected) {
      data = await getMethod<T, K>(endpoint: endpoint);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> multipart<T, K>(
      {required String endpoint,
      Map<String, String>? body,
      List<ImageFile>? files,
      String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await multiPartMethod<T, K>(
          endpoint: endpoint, data: body, files: files, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> appMultipart<T, K>(
      {required String endpoint,
      required String fileFieldName,
      String? thumbFieldName,
      Map<String, dynamic>? body,
      List<File>? files,
      List<File>? thumbFiles,
      String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await appMultiPartMethod<T, K>(
          endpoint: endpoint,
          fileFieldName: fileFieldName,
          thumbFieldName: thumbFieldName,
          data: body,
          files: files,
          thumbFiles: thumbFiles,
          token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> postUrlEncode<T>({required String endpoint, dynamic body}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await postUrlEncodeMethod<T, void>(endpoint: endpoint, data: body);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }
}
