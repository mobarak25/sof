part of 'resources_details_bloc.dart';

class ResourcesDetailsState extends Equatable {
  const ResourcesDetailsState({
    this.isTeacher = false,
    this.details = const ResourceDetails(),
  });

  final bool isTeacher;
  final ResourceDetails details;

  ResourcesDetailsState copyWith({
    bool? isTeacher,
    ResourceDetails? details,
  }) {
    return ResourcesDetailsState(
      isTeacher: isTeacher ?? this.isTeacher,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [isTeacher, details];
}

final class ResourcesDetailsInitial extends ResourcesDetailsState {}
