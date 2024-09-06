import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/mark_entry.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/student_assignment_submissign_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';
import 'package:school_of_future/features/presentation/assignment/student_submission_details/widget/accept_bottom_sheet.dart';
import 'package:school_of_future/features/presentation/assignment/student_submission_details/widget/deny_bottom_sheet.dart';
import 'package:school_of_future/features/presentation/assignment/student_submission_details/widget/resubmit_bottom_sheet.dart';

part 'student_submission_details_event.dart';
part 'student_submission_details_state.dart';

class StudentSubmissionDetailsBloc
    extends Bloc<StudentSubmissionDetailsEvent, StudentSubmissionDetailsState> {
  StudentSubmissionDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentSubmissionDetailsInitial()) {
    on<GetSubmissionDetails>(_getSubmissionDetails);
    on<CheckTeacher>(_checkTeacher);
    on<OpenAcceptSheet>(_openAcceptSheet);
    on<OpenResubmitSheet>(_openResubmitSheet);
    on<OpenDenySheet>(_openDenySheet);
    on<SubmitMark>(_submitMark);
    on<ReSubmit>(_reSubmit);
    on<SubmitDeny>(_submitDeny);

    add(CheckTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getSubmissionDetails(GetSubmissionDetails event,
      Emitter<StudentSubmissionDetailsState> emit) async {
    final details = await _apiRepo.get<StudentAssignmentDetails>(
        endpoint: submitAssignmentDtlsEndPoint(submitId: event.id));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }

  FutureOr<void> _checkTeacher(
      CheckTeacher event, Emitter<StudentSubmissionDetailsState> emit) async {
    final teacher =
        await LocalData.isTeacher(localStorageRepo: _localStorageRepo);

    emit(state.copyWith(isTeacher: teacher));
  }

  FutureOr<void> _openAcceptSheet(
      OpenAcceptSheet event, Emitter<StudentSubmissionDetailsState> emit) {
    openAcceptSheet(
      _iFlutterNavigator.context,
      press: (String marks, String feedback) {
        add(SubmitMark(mark: marks, feedback: feedback));
      },
    );
  }

  FutureOr<void> _openResubmitSheet(
      OpenResubmitSheet event, Emitter<StudentSubmissionDetailsState> emit) {
    openResubmitSheet(
      _iFlutterNavigator.context,
      press: (String date, String feedback) {
        add(ReSubmit(date: date, feedback: feedback));
      },
    );
  }

  FutureOr<void> _openDenySheet(
      OpenDenySheet event, Emitter<StudentSubmissionDetailsState> emit) {
    openDenySheet(
      _iFlutterNavigator.context,
      press: (String feedback) {
        add(SubmitDeny(feedback: feedback));
      },
    );
  }

  FutureOr<void> _submitMark(
      SubmitMark event, Emitter<StudentSubmissionDetailsState> emit) async {
    final submitmark = await _apiRepo.put<DefaultResponse>(
      endpoint: assignmentMarkEntryEndPoint(id: state.details.data!.id!),
      body: MarkEntry(status: '1', marks: event.mark, content: event.feedback),
    );
    if (submitmark != null) {
      ShowSnackBar(
        message: submitmark.message!,
        color: bGreen,
        navigator: _iFlutterNavigator,
      );
      _iFlutterNavigator.pop();
      _iFlutterNavigator.pushReplacementNamed(
          teacherAssignmentViewSubmissionScreen,
          arguments: state.details.data!.studentAssignment!.assignmentId!);
    }
  }

  FutureOr<void> _reSubmit(
      ReSubmit event, Emitter<StudentSubmissionDetailsState> emit) async {
    final resubmit = await _apiRepo.put<DefaultResponse>(
        endpoint: assignmentMarkEntryEndPoint(id: state.details.data!.id!),
        body: {
          "status": 2,
          "late_submission_date": event.date,
          "content": event.feedback
        });

    if (resubmit != null) {
      ShowSnackBar(
        message: resubmit.message!,
        color: bGreen,
        navigator: _iFlutterNavigator,
      );
      _iFlutterNavigator.pop();
      _iFlutterNavigator.pushReplacementNamed(
          teacherAssignmentViewSubmissionScreen,
          arguments: state.details.data!.studentAssignment!.assignmentId!);
    }
  }

  FutureOr<void> _submitDeny(
      SubmitDeny event, Emitter<StudentSubmissionDetailsState> emit) async {
    final deny = await _apiRepo.put<DefaultResponse>(
        endpoint: assignmentMarkEntryEndPoint(id: state.details.data!.id!),
        body: {"status": 3, "content": event.feedback});

    if (deny != null) {
      ShowSnackBar(
        message: deny.message!,
        color: bGreen,
        navigator: _iFlutterNavigator,
      );
      _iFlutterNavigator.pop();
      _iFlutterNavigator.pushReplacementNamed(
          teacherAssignmentViewSubmissionScreen,
          arguments: state.details.data!.studentAssignment!.assignmentId!);
    }
  }
}
