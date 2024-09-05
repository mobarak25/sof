import 'dart:io';

import 'package:school_of_future/core/utils/utilities.dart';

abstract class ApiRepo {
  Future<T?> post<T>({required String endpoint, dynamic body, String? token});
  Future<T?> put<T>({required String endpoint, dynamic body, String? token});

  Future<T?> postForList<T, K>(
      {required String endpoint, dynamic body, String? token});

  Future<T?> get<T>({required String endpoint, dynamic body, String? token});

  Future<T?> getForList<T, K>(
      {required String endpoint, dynamic body, String? token});

  Future<T?> multipart<T, K>(
      {required String endpoint,
      Map<String, String>? body,
      List<ImageFile> files,
      String? token});

  Future<T?> appMultipart<T, K>(
      {required String endpoint,
      required String fileFieldName,
      Map<String, dynamic>? body,
      List<File> files,
      String? token});

  Future<T?> postUrlEncode<T>({required String endpoint, String body});
}
