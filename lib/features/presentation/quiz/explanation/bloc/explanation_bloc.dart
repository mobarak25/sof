import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'explanation_event.dart';
part 'explanation_state.dart';

class ExplanationBloc extends Bloc<ExplanationEvent, ExplanationState> {
  ExplanationBloc() : super(ExplanationInitial()) {
    on<ExplanationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
