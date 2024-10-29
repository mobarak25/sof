import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/save_attendance.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/student_for_attendance_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/attendance/take_attendance/widgets/reset_attendance_modal.dart';
import 'package:school_of_future/features/presentation/attendance/take_attendance/widgets/save_attendance_modal.dart';

part 'take_attendance_event.dart';
part 'take_attendance_state.dart';

class TakeAttendanceBloc
    extends Bloc<TakeAttendanceEvent, TakeAttendanceState> {
  TakeAttendanceBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TakeAttendanceInitial()) {
    on<GetParams>(_getParams);
    on<StudentForAttendance>(_studentForAttendance);
    on<ChangeStatus>(_changeStatus);
    on<Reset>(_reset);
    on<Save>(_save);
    on<ConfirmReset>(_confirmReset);
    on<ConfirmSave>(_confirmSave);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getParams(
      GetParams event, Emitter<TakeAttendanceState> emit) {
    emit(state.copyWith(
      subjectId: event.subjectId,
      batchId: event.batchId,
      classInfo: event.classInfo,
      isDetails: event.isViewDetails,
    ));

    add(StudentForAttendance());
  }

  FutureOr<void> _studentForAttendance(
      StudentForAttendance event, Emitter<TakeAttendanceState> emit) async {
    final queryParams = {
      'date': getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd"),
      'subject_id': state.subjectId,
    };

    final student = await _apiRepo.get<StudentsForAttendance>(
      endpoint: buildUrl(
          studentListForAttendanceEndPoint(batchId: state.batchId),
          queryParams),
    );

    if (student != null) {
      int leave = 0;
      int absent = 0;
      int present = 0;
      int late = 0;

      for (var item in student.data!) {
        if (item.attendanceStatus == 0) {
          absent++;
        } else if (item.attendanceStatus == 1) {
          present++;
        } else if (item.attendanceStatus == 2) {
          leave++;
        } else if (item.attendanceStatus == 3) {
          late++;
        }
      }
      emit(state.copyWith(
        students: student,
        absentCount: absent,
        leaveCount: leave,
        presentCount: present,
        tempStudents: student.data,
        lateCount: late,
      ));
    }
  }

  FutureOr<void> _changeStatus(
      ChangeStatus event, Emitter<TakeAttendanceState> emit) {
    final updatedStudents = List<StudentInfo>.from(state.students.data!);

    updatedStudents[event.index] = StudentInfo(
      id: updatedStudents[event.index].id,
      userId: updatedStudents[event.index].userId,
      batchId: updatedStudents[event.index].batchId,
      imageUrl: updatedStudents[event.index].imageUrl,
      firstName: updatedStudents[event.index].firstName,
      middleName: updatedStudents[event.index].middleName,
      lastName: updatedStudents[event.index].lastName,
      classRollNo: updatedStudents[event.index].classRollNo,
      admissionNumber: updatedStudents[event.index].admissionNumber,
      attendanceStatus: updatedStudents[event.index].attendanceStatus < 3
          ? (updatedStudents[event.index].attendanceStatus + 1)
          : 0, // Changing the attendance status
      fullName: updatedStudents[event.index].fullName,
    );

    int present = 0;
    int absent = 0;
    int late = 0;
    int leave = 0;

    for (var item in updatedStudents) {
      if (item.attendanceStatus == 1) {
        present++;
      } else if (item.attendanceStatus == 2) {
        leave++;
      } else if (item.attendanceStatus == 3) {
        late++;
      } else if (item.attendanceStatus == 0) {
        absent++;
      }
    }

    emit(
      state.copyWith(
        students: StudentsForAttendance(data: updatedStudents),
        presentCount: present,
        absentCount: absent,
        lateCount: late,
        leaveCount: leave,
      ),
    );
  }

  FutureOr<void> _reset(Reset event, Emitter<TakeAttendanceState> emit) {
    showAttendanceResetDialog(_iFlutterNavigator.context, pressToYes: () {
      add(ConfirmReset());
    });
  }

  FutureOr<void> _confirmReset(
      ConfirmReset event, Emitter<TakeAttendanceState> emit) {
    _iFlutterNavigator.pop();
    int present = 0;
    int leave = 0;
    int absent = 0;
    int late = 0;
    for (var item in state.tempStudents) {
      if (item.attendanceStatus == 0) {
        absent++;
      } else if (item.attendanceStatus == 1) {
        present++;
      } else if (item.attendanceStatus == 2) {
        leave++;
      } else if (item.attendanceStatus == 3) {
        late++;
      }
    }

// here is "tempStudents"
    emit(
      state.copyWith(
        students: StudentsForAttendance(
          data: List.generate(
            state.students.data!.length,
            (index) => StudentInfo(
              id: state.students.data![index].id,
              userId: state.students.data![index].userId,
              batchId: state.students.data![index].batchId,
              imageUrl: state.students.data![index].imageUrl,
              firstName: state.students.data![index].firstName,
              middleName: state.students.data![index].middleName,
              lastName: state.students.data![index].lastName,
              classRollNo: state.students.data![index].classRollNo,
              admissionNumber: state.students.data![index].admissionNumber,
              attendanceStatus: state.tempStudents[index].attendanceStatus,
              fullName: state.students.data![index].fullName,
            ),
          ),
        ),
        presentCount: present,
        lateCount: late,
        absentCount: absent,
        leaveCount: leave,
      ),
    );
  }

  FutureOr<void> _save(Save event, Emitter<TakeAttendanceState> emit) {
    showAttendanceSaveDialog(_iFlutterNavigator.context, pressToYes: () {
      add(ConfirmSave());
    });
  }

  FutureOr<void> _confirmSave(
      ConfirmSave event, Emitter<TakeAttendanceState> emit) async {
    List<int> studentId = [];
    List<int> attendance = [];

    for (int i = 0; i < state.students.data!.length; i++) {
      studentId.add(state.students.data![i].id!);
      attendance.add(state.students.data![i].attendanceStatus!);
    }

    final save = await _apiRepo.post<DefaultResponse>(
      endpoint: state.subjectId == -1
          ? teacherAttendanceEndPoint
          : subjectWiseAttendanceSaveEndPoint,
      body: SaveAttendance(
          batchId: state.batchId,
          subjectId: state.subjectId,
          date:
              getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd"),
          studentId: studentId,
          attendance: attendance),
    );

    if (save != null) {
      Navigator.of(_iFlutterNavigator.context)
          .popUntil((route) => route.isFirst);

      Navigator.of(navigatorKey.currentState!.context, rootNavigator: false)
          .pushReplacementNamed(teacherAttendanceScreen);

      ShowSnackBar(message: save.message!, navigator: _iFlutterNavigator);
    }
  }
}
