class ExamMarkEntry {
  final List<EntryOfStudent>? data;

  const ExamMarkEntry({
    this.data,
  });

  factory ExamMarkEntry.fromJson(Map<String, dynamic> json) => ExamMarkEntry(
        data: json["data"] == null
            ? []
            : List<EntryOfStudent>.from(
                json["data"]!.map((x) => EntryOfStudent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EntryOfStudent {
  final int? id;
  final String? admissionNumber;
  final String? classRollNo;
  final String? imageUrl;
  final String? firstName;
  final Score? score;
  final String? fullName;

  EntryOfStudent({
    this.id,
    this.admissionNumber,
    this.classRollNo,
    this.imageUrl,
    this.firstName,
    this.score,
    this.fullName,
  });

  factory EntryOfStudent.fromJson(Map<String, dynamic> json) => EntryOfStudent(
        id: json["id"],
        admissionNumber: json["admission_number"],
        classRollNo: json["class_roll_no"],
        imageUrl: json["image_url"],
        firstName: json["first_name"],
        score: json["score"] == null ? null : Score.fromJson(json["score"]),
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admission_number": admissionNumber,
        "class_roll_no": classRollNo,
        "image_url": imageUrl,
        "first_name": firstName,
        "score": score?.toJson(),
        "full_name": fullName,
      };
}

class Score {
  final int? id;
  final int? examId;
  final int? studentId;
  final String? mark;
  final int? isPassed;
  final int? isAbsent;

  Score({
    this.id,
    this.examId,
    this.studentId,
    this.mark,
    this.isPassed,
    this.isAbsent,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        id: json["id"],
        examId: json["exam_id"],
        studentId: json["student_id"],
        mark: json["mark"],
        isPassed: json["is_passed"],
        isAbsent: json["is_absent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "exam_id": examId,
        "student_id": studentId,
        "mark": mark,
        "is_passed": isPassed,
        "is_absent": isAbsent,
      };
}
