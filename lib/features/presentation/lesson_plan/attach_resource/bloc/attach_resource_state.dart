part of 'attach_resource_bloc.dart';

class AttachResourceState extends Equatable {
  const AttachResourceState({
    this.allResource = const Resources(),
    this.allCheckUncheck = const [],
    this.copyCheckUncheck = const [],
    this.checkedId = const [],
  });

  final List<int> checkedId;
  final Resources allResource;
  final List<CheckUncheckResources> allCheckUncheck;
  final List<CheckUncheckResources> copyCheckUncheck;

  AttachResourceState copyWith({
    List<int>? checkedId,
    Resources? allResource,
    List<CheckUncheckResources>? allCheckUncheck,
    List<CheckUncheckResources>? copyCheckUncheck,
  }) {
    return AttachResourceState(
      checkedId: checkedId ?? this.checkedId,
      allResource: allResource ?? this.allResource,
      allCheckUncheck: allCheckUncheck ?? this.allCheckUncheck,
      copyCheckUncheck: copyCheckUncheck ?? this.copyCheckUncheck,
    );
  }

  @override
  List<Object> get props =>
      [checkedId, allResource, allCheckUncheck, copyCheckUncheck];
}

final class AttachResourceInitial extends AttachResourceState {}
