import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/transport_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'transport_event.dart';
part 'transport_state.dart';

class TransportBloc extends Bloc<TransportEvent, TransportState> {
  TransportBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TransportInitial()) {
    on<GetTransport>(_getTransport);

    add(GetTransport());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getTransport(
      GetTransport event, Emitter<TransportState> emit) async {
    final loginId =
        await LocalData.loginId(localStorageRepo: _localStorageRepo)!;

    final transport = await _apiRepo.get<Transport>(
        endpoint: transportEndPoint(loingId: loginId));

    if (transport != null) {
      emit(state.copyWith(transport: transport));
    }
  }
}
