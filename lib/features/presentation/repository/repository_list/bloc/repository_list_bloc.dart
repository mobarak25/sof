import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';

import 'package:school_of_future/features/domain/entities/respsitory_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'repository_list_event.dart';
part 'repository_list_state.dart';

class RepositoryListBloc
    extends Bloc<RepositoryListEvent, RepositoryListState> {
  RepositoryListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(RepositoryListInitial()) {
    on<GetRepository>(_getRepository);
    on<ChangeSearch>(_changeSearch);
    on<PageIncrement>(_pageIncrement);

    add(GetRepository());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getRepository(
      GetRepository event, Emitter<RepositoryListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
    };

    final response = await _apiRepo.get<Repositories>(
        endpoint: buildUrl(repositoryListEndPoint, queryParams));

    if (response != null) {
      emit(state.copyWith(repositories: response));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<RepositoryListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetRepository());
    });
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<RepositoryListState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.repositories.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
        };

        final pagiRepository = await _apiRepo.get<Repositories>(
            endpoint: buildUrl(repositoryListEndPoint, queryParams));

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiRepository != null) {
          emit(state.copyWith(
              repositories: Repositories(
            data: state.repositories.data! + pagiRepository.data!,
            lastPage: pagiRepository.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
