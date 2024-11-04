class CreateQuestionPaper {
  final int subjectId;
  final int batchId;
  final String name;
  final String type;
  final String datetime;
  final String duration;
  final num fullMark;
  final List<int> questionId;
  final List<String> questionMark;

  CreateQuestionPaper({
    required this.subjectId,
    required this.batchId,
    required this.name,
    required this.type,
    required this.datetime,
    required this.duration,
    required this.fullMark,
    required this.questionId,
    required this.questionMark,
  });

  factory CreateQuestionPaper.fromJson(Map<String, dynamic> json) =>
      CreateQuestionPaper(
        subjectId: json["subject_id"],
        batchId: json["batch_id"],
        name: json["name"],
        type: json["type"],
        datetime: json["datetime"],
        duration: json["duration"],
        fullMark: json["full_mark"],
        questionId: List<int>.from(json["question_id"].map((x) => x)),
        questionMark: List<String>.from(json["question_mark"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "batch_id": batchId,
        "name": name,
        "type": type,
        "datetime": datetime,
        "duration": duration,
        "full_mark": fullMark,
        "question_id": List<dynamic>.from(questionId.map((x) => x)),
        "question_mark": List<dynamic>.from(questionMark.map((x) => x)),
      };
}
