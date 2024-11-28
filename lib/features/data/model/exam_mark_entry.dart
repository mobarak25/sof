class ExamMarkEntryModal {
  final List<MarkHolder> marks;

  ExamMarkEntryModal({
    required this.marks,
  });

  factory ExamMarkEntryModal.fromJson(Map<String, dynamic> json) =>
      ExamMarkEntryModal(
        marks: List<MarkHolder>.from(
            json["marks"].map((x) => MarkHolder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "marks": List<dynamic>.from(marks.map((x) => x.toJson())),
      };
}

class MarkHolder {
  final int studentId;
  final String mark;

  MarkHolder({
    required this.studentId,
    required this.mark,
  });

  factory MarkHolder.fromJson(Map<String, dynamic> json) => MarkHolder(
        studentId: json["student_id"],
        mark: json["mark"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "mark": mark,
      };
}
