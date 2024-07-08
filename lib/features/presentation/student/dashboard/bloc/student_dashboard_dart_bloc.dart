import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_dashboard_dart_event.dart';
part 'student_dashboard_dart_state.dart';

class StudentDashboardDartBloc extends Bloc<StudentDashboardDartEvent, StudentDashboardDartState> {
  StudentDashboardDartBloc() : super(StudentDashboardDartInitial()) {
    on<StudentDashboardDartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
