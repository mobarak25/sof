class AssignmentSearch {
  final int? submissionStatus;
  final String? search;
  final String? startDate;
  final String? endDate;
  final String? subjectId;

  AssignmentSearch({
    this.submissionStatus,
    this.search,
    this.startDate,
    this.endDate,
    this.subjectId,
  });

  factory AssignmentSearch.fromJson(Map<String, dynamic> json) =>
      AssignmentSearch(
        submissionStatus: json["submission_status"],
        search: json["search"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        subjectId: json["subject_id"],
      );

  Map<String, dynamic> toJson() => {
        "submission_status": submissionStatus,
        "search": search,
        "start_date": startDate,
        "end_date": endDate,
        "subject_id": subjectId,
      };
}
