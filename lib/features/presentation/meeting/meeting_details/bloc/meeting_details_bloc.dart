import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/meeting_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_details/widgets/student_list_modal.dart';

part 'meeting_details_event.dart';
part 'meeting_details_state.dart';

class MeetingDetailsBloc
    extends Bloc<MeetingDetailsEvent, MeetingDetailsState> {
  MeetingDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(MeetingDetailsInitial()) {
    on<GetMeetingDetails>(_getMeetingDetails);
    on<OpenListDialog>(_openListDialog);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getMeetingDetails(
      GetMeetingDetails event, Emitter<MeetingDetailsState> emit) async {
    List<BatchWiseStudentItem>? assignStudents = [];
    final details = await _apiRepo.get<MeetingDetails>(
        endpoint: teacherMeetingDetailsEndPoint(meetingId: event.meetingId));

    if (details != null) {
      for (int i = 0; i < details.data!.meetingBatches!.length; i++) {
        final student = await _apiRepo.get<BatchWiseStudent>(
            endpoint: getBatchWiseStudentsByBatchIdEndpoint(
                batchId: details.data!.meetingBatches![i]));

        if (student != null) {
          for (int j = 0; j < student.data!.length; j++) {
            if (details.data!.meetingStudents!.contains(student.data![j].id)) {
              assignStudents.add(student.data![j]);
            }
          }
        }
      }

      emit(state.copyWith(details: details, assignStudents: assignStudents));
    }
  }

  FutureOr<void> _openListDialog(
      OpenListDialog event, Emitter<MeetingDetailsState> emit) {
    showStudentListDialog(_iFlutterNavigator.context,
        students: state.assignStudents);
  }
}
