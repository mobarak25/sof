import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/leave_types_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_leave_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_apply_leave_event.dart';
part 'teacher_apply_leave_state.dart';

class TeacherApplyLeaveBloc
    extends Bloc<TeacherApplyLeaveEvent, TeacherApplyLeaveState> {
  TeacherApplyLeaveBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(TeacherApplyLeaveInitial()) {
    on<OwnLeaveIdForEdit>(_leaveIdForEdit);
    on<GetLeaveType>(_getLeaveType);

    on<SelectLeaveType>(_selectLeaveType);
    on<SelectStartDate>(_selectStartDate);
    on<SelectEnd>(_selectEnd);
    on<GetIsHalfDay>(_getIsHalfDay);
    on<GetIsEmergency>(_getIsEmergency);
    on<ChangeDescription>(_changeDescription);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<PressToApply>(_pressToApply);
    on<AddData>(_addData);

    add(GetLeaveType());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _getLeaveType(
      GetLeaveType event, Emitter<TeacherApplyLeaveState> emit) async {
    final loginUserId = _localStorageRepo.read(key: loginIdDB)!;

    List<DropdownItem> list = [const DropdownItem(name: "Select", value: -1)];
    final types =
        await _apiRepo.get<LeaveTypes>(endpoint: teacherLeaveTypeEndPoint);

    if (types != null) {
      for (int i = 0; i < types.data!.length; i++) {
        list.add(
          DropdownItem(name: types.data![i].name!, value: types.data![i].id!),
        );
      }
      emit(state.copyWith(
          leaveList: types, leaveDropdown: list, loginId: loginUserId));
    }
  }

  FutureOr<void> _leaveIdForEdit(
      OwnLeaveIdForEdit event, Emitter<TeacherApplyLeaveState> emit) async {
    emit(state.copyWith(leaveId: event.leaveId));

    if (event.leaveId != -1) {
      final details = await _apiRepo.get<TeacherLeaveDetails>(
        endpoint: teacherOwnLeaveDtlsEndPoint(id: event.leaveId),
      );

      if (details != null) {
        emit(state.copyWith(details: details));
        add(SelectLeaveType(value: state.details.data!.leaveTypeId));
      }
    }
  }

  FutureOr<void> _selectLeaveType(
      SelectLeaveType event, Emitter<TeacherApplyLeaveState> emit) {
    emit(state.copyWith(leaveType: event.value));
  }

  FutureOr<void> _selectStartDate(
      SelectStartDate event, Emitter<TeacherApplyLeaveState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.startDate);
    event.startController.text =
        DateFormat('dd MMM yyyy').format(event.startDate);

    if (event.endController.text.isEmpty) {
      event.endController.text =
          DateFormat('dd MMM yyyy').format(event.startDate);
      emit(state.copyWith(endDate: date));
    }
    int days = 0;
    if (state.endDate.isNotEmpty) {
      int count =
          DateTime.parse(state.endDate).difference(DateTime.parse(date)).inDays;
      if (count >= 0) {
        days = count + 1;
      } else {
        days = count;
      }
    }

    emit(state.copyWith(
        startDate: date,
        dateCount: days,
        tempDateCount: days,
        isHalfDay: false));
  }

  FutureOr<void> _selectEnd(
      SelectEnd event, Emitter<TeacherApplyLeaveState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.endDate);
    event.endController.text = DateFormat('dd MMM yyyy').format(event.endDate);

    if (event.startController.text.isEmpty) {
      event.startController.text =
          DateFormat('dd MMM yyyy').format(event.endDate);
      emit(state.copyWith(startDate: date));
    }

    int days = 0;
    if (state.startDate.isNotEmpty) {
      int count =
          event.endDate.difference(DateTime.parse(state.startDate)).inDays;
      if (count >= 0) {
        days = count + 1;
      } else {
        days = count;
      }
    }

    emit(state.copyWith(
        endDate: date, dateCount: days, tempDateCount: days, isHalfDay: false));
  }

  FutureOr<void> _getIsHalfDay(
      GetIsHalfDay event, Emitter<TeacherApplyLeaveState> emit) {
    if (event.isHalfDay) {
      emit(state.copyWith(tempDateCount: state.tempDateCount / 2));
    } else {
      emit(state.copyWith(tempDateCount: state.dateCount));
    }
    emit(state.copyWith(isHalfDay: event.isHalfDay));
  }

  FutureOr<void> _getIsEmergency(
      GetIsEmergency event, Emitter<TeacherApplyLeaveState> emit) {
    emit(state.copyWith(isEmergency: event.isEmergency));
  }

  FutureOr<void> _changeDescription(
      ChangeDescription event, Emitter<TeacherApplyLeaveState> emit) {
    emit(state.copyWith(description: event.desc));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<TeacherApplyLeaveState> emit) async {
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
      RemoveFile event, Emitter<TeacherApplyLeaveState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _pressToApply(
      PressToApply event, Emitter<TeacherApplyLeaveState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.appMultipart<DefaultResponse, void>(
        endpoint: state.leaveId != -1
            ? teacherOwnLeaveDtlsEndPoint(id: state.leaveId)
            : teacherOwnLeaveEndPoint,
        body: {
          "leave_type_id": state.leaveType, // sick/genaral
          "application_type": state.isHalfDay ? 2 : 1,
          "comment": state.description,
          "from_date": state.startDate,
          "to_date": state.endDate,
          "application_date":
              getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd"),
          "is_emergency": state.isEmergency ? 1 : 0,
          "_method": state.leaveId == -1 ? "POST" : "PUT",
        },
        fileFieldName: "attachment",
        files: state.fileList,
      );

      if (create != null) {
        _iFlutterNavigator.pop();
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            teacherOwnleaveListScreen, ModalRoute.withName('/'));
        ShowSnackBar(message: create.message!, navigator: _iFlutterNavigator);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _addData(AddData event, Emitter<TeacherApplyLeaveState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        startDate: event.startDate,
        endDate: event.endDate,
        leaveType: event.selectedType,
        description: event.desc,
        isHalfDay: event.isHalfDay,
        isEmergency: event.isEmergency,
        isFirstTime: false,
      ));
    }
  }

  bool isValid(PressToApply event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.startDate, focusNode: event.startFocusnode),
      FormItem(text: state.endDate, focusNode: event.endFocusnode),
      FormItem(text: state.description, focusNode: event.descFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.startDate.isEmpty ||
        state.endDate.isEmpty ||
        state.description.isEmpty ||
        state.leaveType == -1) {
      return false;
    }
    return true;
  }
}
