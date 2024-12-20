import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

abstract class FilePickerRepo {
  Future<FilePickerResult?> filePicker({bool? isMultiple = true});
  //Future<String?> getAddress({required double lat, required double lng});
}

@LazySingleton(as: FilePickerRepo)
class FilePickerRepoImpl implements FilePickerRepo {
  FilePickerRepoImpl();

  @override
  Future<FilePickerResult?> filePicker({bool? isMultiple = true}) async {
    return await FilePicker.platform.pickFiles(allowMultiple: isMultiple!);
  }
}
