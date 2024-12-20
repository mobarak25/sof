part of 'filter_sidebar_bloc.dart';

sealed class FilterSidebarEvent extends Equatable {
  const FilterSidebarEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends FilterSidebarEvent {}

class SelectStartDate extends FilterSidebarEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class SelectEndDate extends FilterSidebarEvent {
  const SelectEndDate({
    required this.endDate,
    required this.endDateController,
  });
  final DateTime endDate;
  final TextEditingController endDateController;
}

class GetVersionList extends FilterSidebarEvent {}

class SelectVersionId extends FilterSidebarEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends FilterSidebarEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends FilterSidebarEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends FilterSidebarEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

class SelectChapterId extends FilterSidebarEvent {
  const SelectChapterId({required this.id});
  final dynamic id;
}

class SelectSubjectIdForStudent extends FilterSidebarEvent {
  const SelectSubjectIdForStudent({required this.id});
  final dynamic id;
}

class GetSubjectForStudent extends FilterSidebarEvent {}

class GetChapter extends FilterSidebarEvent {
  const GetChapter({required this.subjectId});
  final dynamic subjectId;
}

class CheckValidation extends FilterSidebarEvent {}
