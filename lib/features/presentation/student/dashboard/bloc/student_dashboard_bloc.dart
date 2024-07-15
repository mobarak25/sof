import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
part 'student_dashboard_event.dart';
part 'student_dashboard_state.dart';

class StudentDashboardBloc
    extends Bloc<StudentDashboardEvent, StudentDashboardState> {
  StudentDashboardBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentDashboardInitial()) {
    on<PanelControlOnClick>(_panelControlOnClick);
    on<GetOpenClose>(_getOpenClose);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getOpenClose(
      GetOpenClose event, Emitter<StudentDashboardState> emit) {
    emit(state.copyWith(panelIsOpen: event.isOPen));
  }

  FutureOr<void> _panelControlOnClick(
      PanelControlOnClick event, Emitter<StudentDashboardState> emit) async {
    if (state.panelIsOpen) {
      await event.panelController.close();
    } else {
      await event.panelController.open();
    }
  }
}
