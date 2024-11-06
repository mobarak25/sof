import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/respository_details.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'repository_details_event.dart';
part 'repository_details_state.dart';

class RepositoryDetailsBloc
    extends Bloc<RepositoryDetailsEvent, RepositoryDetailsState> {
  RepositoryDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(RepositoryDetailsInitial()) {
    on<GetRepositoryDetails>(_getRepositoryDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getRepositoryDetails(
      GetRepositoryDetails event, Emitter<RepositoryDetailsState> emit) async {
    final details = await _apiRepo.get<RepositoryDetails>(
        endpoint: repositoryDtlsEndPoint(id: event.id));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
