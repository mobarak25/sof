class CerateExam {
  final String date;
  final int subjectId;
  final int batchId;
  final int examGroupId;
  final String maxMark;
  final String convertMark;
  final String passMark;
  final String startTime;
  final String endTime;
  final int isPublished;
  final int termId;

  CerateExam({
    required this.date,
    required this.subjectId,
    required this.batchId,
    required this.examGroupId,
    required this.maxMark,
    required this.convertMark,
    required this.passMark,
    required this.startTime,
    required this.endTime,
    required this.isPublished,
    required this.termId,
  });

  factory CerateExam.fromJson(Map<String, dynamic> json) => CerateExam(
        date: json["date"],
        subjectId: json["subject_id"],
        batchId: json["batch_id"],
        examGroupId: json["exam_group_id"],
        maxMark: json["max_mark"],
        convertMark: json["convert_mark"],
        passMark: json["pass_mark"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        isPublished: json["is_published"],
        termId: json["term_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "subject_id": subjectId,
        "batch_id": batchId,
        "exam_group_id": examGroupId,
        "max_mark": maxMark,
        "convert_mark": convertMark,
        "pass_mark": passMark,
        "start_time": startTime,
        "end_time": endTime,
        "is_published": isPublished,
        "term_id": termId,
      };
}
