import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/full_syllabus_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

part 'teacher_full_syllabus_details_event.dart';
part 'teacher_full_syllabus_details_state.dart';

class TeacherFullSyllabusDetailsBloc extends Bloc<
    TeacherFullSyllabusDetailsEvent, TeacherFullSyllabusDetailsState> {
  TeacherFullSyllabusDetailsBloc(this._apiRepo)
      : super(TeacherFullSyllabusDetailsInitial()) {
    on<GetTeacherSyllabusDetails>(_getTeacherSyllabusDetails);
  }

  final ApiRepo _apiRepo;

  FutureOr<void> _getTeacherSyllabusDetails(GetTeacherSyllabusDetails event,
      Emitter<TeacherFullSyllabusDetailsState> emit) async {
    final details = await _apiRepo.get<FullSyllabusDetails>(
        endpoint:
            teacherFullSyllabusDtlsEndPoint(syllabusId: event.syllabusId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
