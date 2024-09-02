part of 'student_assignment_submit_bloc.dart';

class StudentAssignmentSubmitState extends Equatable {
  const StudentAssignmentSubmitState({
    this.loading = false,
    this.id = 0,
    this.fileList = const [],
    this.content = '',
    this.forms = Forms.initial,
  });

  final bool loading;
  final Forms forms;
  final int id;
  final List<File> fileList;
  final String content;

  StudentAssignmentSubmitState copyWith({
    int? id,
    bool? loading,
    Forms? forms,
    String? content,
    List<File>? fileList,
  }) {
    return StudentAssignmentSubmitState(
      id: id ?? this.id,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      content: content ?? this.content,
      fileList: fileList ?? this.fileList,
    );
  }

  @override
  List<Object> get props => [loading, forms, id, fileList, content];
}

final class StudentAssignmentSubmitInitial
    extends StudentAssignmentSubmitState {}
