import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

class LocalData {
  // static Future<bool>? isSupervisor(
  //     {required LocalStorageRepo localStorageRepo}) async {
  //   final userDtl =
  //       await localStorageRepo.readModel<LoginResponse>(key: userDtlDB);
  //   return userDtl!.data!.user!.isSupervisor!;
  // }

  static Future<bool>? isTeacher(
      {required LocalStorageRepo localStorageRepo}) async {
    final userType = localStorageRepo.read(key: userTypeDB);
    return userType == '2' ? true : false;
  }

  static Future<String>? loginId(
      {required LocalStorageRepo localStorageRepo}) async {
    final userType = localStorageRepo.read(key: loginIdDB)!;
    return userType;
  }
}
