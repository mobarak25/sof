import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'classwork_list_event.dart';
part 'classwork_list_state.dart';

class ClassworkListBloc extends Bloc<ClassworkListEvent, ClassworkListState> {
  ClassworkListBloc() : super(ClassworkListInitial()) {
    on<ClassworkListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
