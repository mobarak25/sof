import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/presentation/leave/apply_leave/widgets/file_bottom_sheet.dart';
part 'apply_leave_event.dart';
part 'apply_leave_state.dart';

class ApplyLeaveBloc extends Bloc<ApplyLeaveEvent, ApplyLeaveState> {
  ApplyLeaveBloc(
      this._iFlutterNavigator, this._imagePicker, this._filePickerRepo)
      : super(ApplyLeaveInitial()) {
    on<ChangeTitle>(_changeTitle);
    on<SelectLeaveType>(_selectLeaveType);
    on<SelectStartDate>(_selectStartDate);
    on<SelectEnd>(_selectEnd);
    on<GetIsHalfDay>(_getIsHalfDay);
    on<ChangeDescription>(_changeDescription);
    on<OpenBottomSheet>(_openBottomSheet);
    on<PickImage>(_pickImage);
    on<GetFile>(_getFile);
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ImagePicker _imagePicker;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<ApplyLeaveState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _selectLeaveType(
      SelectLeaveType event, Emitter<ApplyLeaveState> emit) {
    emit(state.copyWith(leaveType: event.value));
  }

  FutureOr<void> _selectStartDate(
      SelectStartDate event, Emitter<ApplyLeaveState> emit) {
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

  FutureOr<void> _selectEnd(SelectEnd event, Emitter<ApplyLeaveState> emit) {
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
      GetIsHalfDay event, Emitter<ApplyLeaveState> emit) {
    if (event.isHalfDay) {
      emit(state.copyWith(tempDateCount: state.tempDateCount / 2));
    } else {
      emit(state.copyWith(tempDateCount: state.dateCount));
    }
    emit(state.copyWith(isHalfDay: event.isHalfDay));
  }

  FutureOr<void> _changeDescription(
      ChangeDescription event, Emitter<ApplyLeaveState> emit) {
    emit(state.copyWith(description: event.desc));
  }

  FutureOr<void> _openBottomSheet(
      OpenBottomSheet event, Emitter<ApplyLeaveState> emit) {
    openFileBottomSheet(
      _iFlutterNavigator.context,
      press: (ImageSource sourceType) {
        add(PickImage(imageSource: sourceType));
      },
    );
  }

  FutureOr<void> _pickImage(
      PickImage event, Emitter<ApplyLeaveState> emit) async {
    XFile? file = await _imagePicker.pickImage(
        source: event.imageSource, imageQuality: 20);

    if (file != null) {
      _iFlutterNavigator.pop();
      emit(state.copyWith(
        leaveFile: [ImageFile(name: 'FileAttachment', file: file)],
      ));
    }
  }

  FutureOr<void> _getFile(GetFile event, Emitter<ApplyLeaveState> emit) async {
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
}
