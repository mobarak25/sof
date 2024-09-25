part of 'resources_details_bloc.dart';

sealed class ResourcesDetailsState extends Equatable {
  const ResourcesDetailsState();
  
  @override
  List<Object> get props => [];
}

final class ResourcesDetailsInitial extends ResourcesDetailsState {}
