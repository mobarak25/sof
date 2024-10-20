import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/student_for_attendance_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

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
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getParams(
      GetParams event, Emitter<TakeAttendanceState> emit) {
    emit(state.copyWith(
        subjectId: event.subjectId,
        batchId: event.batchId,
        classInfo: event.classInfo));

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
      emit(state.copyWith(students: student));
    }
  }

  FutureOr<void> _changeStatus(
      ChangeStatus event, Emitter<TakeAttendanceState> emit) {
    final updatedStudents = List<StudentInfo>.from(state.students.data!);

    emit(state.copyWith(tempIndex: event.index));
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

    // Update the specific item at event.index

    // Emit the updated state with the modified list

    print(updatedStudents[event.index].attendanceStatus);
    emit(
        state.copyWith(students: StudentsForAttendance(data: updatedStudents)));
  }
}
