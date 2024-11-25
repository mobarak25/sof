class UpdateShortQuestionMark {
  final int quizId;
  final int studentId;
  final List<Mark> marks;

  UpdateShortQuestionMark({
    required this.quizId,
    required this.studentId,
    required this.marks,
  });

  factory UpdateShortQuestionMark.fromJson(Map<String, dynamic> json) =>
      UpdateShortQuestionMark(
        quizId: json["quiz_id"],
        studentId: json["student_id"],
        marks: List<Mark>.from(json["marks"].map((x) => Mark.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "student_id": studentId,
        "marks": List<dynamic>.from(marks.map((x) => x.toJson())),
      };
}

class Mark {
  final int questionId;
  num? mark;
  final String markingExplaination;

  Mark({
    required this.questionId,
    this.mark,
    required this.markingExplaination,
  });

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        questionId: json["question_id"],
        mark: json["mark"],
        markingExplaination: json["marking_explaination"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "mark": mark,
        "marking_explaination": markingExplaination,
      };
}
