import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/login_response.dart';
import 'package:school_of_future/features/domain/entities/me_response.dart';

class EntityMap {
  static T? fromJson<T, K>(dynamic json) {
    switch (T) {
      case const (DefaultResponse):
        return DefaultResponse.fromJson(json) as T;
      case const (LoginResponse):
        return LoginResponse.fromJson(json) as T;
      case const (MeResponse):
        return MeResponse.fromJson(json) as T;

      default:
        throw Exception('Unknown class');
    }
  }
}
