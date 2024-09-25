import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'resources_details_event.dart';
part 'resources_details_state.dart';

class ResourcesDetailsBloc extends Bloc<ResourcesDetailsEvent, ResourcesDetailsState> {
  ResourcesDetailsBloc() : super(ResourcesDetailsInitial()) {
    on<ResourcesDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
