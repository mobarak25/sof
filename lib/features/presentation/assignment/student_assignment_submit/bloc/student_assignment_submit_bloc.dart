import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/core/widgets/confirm_cancel_dialog.dart';

part 'student_assignment_submit_event.dart';
part 'student_assignment_submit_state.dart';

class StudentAssignmentSubmitBloc
    extends Bloc<StudentAssignmentSubmitEvent, StudentAssignmentSubmitState> {
  StudentAssignmentSubmitBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(StudentAssignmentSubmitInitial()) {
    on<SubmitAssignment>(_submitAssignment);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<PressToSumit>(_pressToSumit);
    on<PressToDraft>(_pressToDraft);
    on<PressToCancel>(_pressToCancel);
    on<PressToConfirmCancel>(_pressToConfirmCancel);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _submitAssignment(
      SubmitAssignment event, Emitter<StudentAssignmentSubmitState> emit) {
    emit(state.copyWith(id: event.id));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<StudentAssignmentSubmitState> emit) async {
    FilePickerResult? result = await _filePickerRepo.filePicker();

    List<File> tempFileList = [];

    if (result != null) {
      final files = result.paths
          .map((path) => path != null ? File(path) : File(''))
          .toList();
      tempFileList.clear();
      tempFileList.addAll(files);

      files.map((newFile) {
        state.fileList.map((oldFile) {
          if (newFile.path == oldFile.path) {
            tempFileList.remove(newFile);
          }
        });
      });

      emit(state.copyWith(fileList: state.fileList + tempFileList));
    } else {}
  }

  FutureOr<void> _removeFile(
      RemoveFile event, Emitter<StudentAssignmentSubmitState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _pressToSumit(
      PressToSumit event, Emitter<StudentAssignmentSubmitState> emit) async {
    emit(state.copyWith(content: event.work));

    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final submitResponse = await _apiRepo.appMultipart<DefaultResponse, void>(
          endpoint: assignmentSubmitEndPoint,
          body: {
            "assignment_id": state.id,
            "is_draft": 0,
            "content": state.content,
          },
          files: state.fileList,
          fileFieldName: "assignment_attachment");
      if (submitResponse != null) {
        Navigator.of(_iFlutterNavigator.context)
            .popUntil((route) => route.isFirst);
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            studentAssignmentListScreen, ModalRoute.withName('/'));

        ShowSnackBar(
            message: submitResponse.message!, navigator: _iFlutterNavigator);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToSumit event) {
    // final validate = Validator.isValidated(items: [
    //   FormItem(text: state.userName, focusNode: event.userNameFocusNode),
    //   FormItem(text: state.password, focusNode: event.passwordFocusNode),
    // ], navigator: _iFlutterNavigator);

    //if (!validate) return false;
    if (state.fileList.isEmpty || state.content == '<br> ') {
      return false;
    }
    return true;
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<StudentAssignmentSubmitState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      add(PressToConfirmCancel());
    });
  }

  FutureOr<void> _pressToConfirmCancel(
      PressToConfirmCancel event, Emitter<StudentAssignmentSubmitState> emit) {
    Navigator.of(_iFlutterNavigator.context).popUntil((route) => route.isFirst);
  }

  FutureOr<void> _pressToDraft(
      PressToDraft event, Emitter<StudentAssignmentSubmitState> emit) async {
    emit(state.copyWith(content: event.work));

    if (isValidDraft(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final submitResponse = await _apiRepo.appMultipart<DefaultResponse, void>(
          endpoint: assignmentSubmitEndPoint,
          body: {
            "assignment_id": state.id,
            "is_draft": 1,
            "content": state.content,
          },
          files: state.fileList,
          fileFieldName: "assignment_attachment");
      if (submitResponse != null) {
        Navigator.of(_iFlutterNavigator.context)
            .popUntil((route) => route.isFirst);
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            studentAssignmentListScreen, ModalRoute.withName('/'));

        ShowSnackBar(
            message: submitResponse.message!, navigator: _iFlutterNavigator);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValidDraft(PressToDraft event) {
    // final validate = Validator.isValidated(items: [
    //   FormItem(text: state.userName, focusNode: event.userNameFocusNode),
    //   FormItem(text: state.password, focusNode: event.passwordFocusNode),
    // ], navigator: _iFlutterNavigator);

    //if (!validate) return false;
    if (state.fileList.isEmpty || state.content == '<br> ') {
      return false;
    }
    return true;
  }
}
