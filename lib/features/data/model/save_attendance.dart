class SaveAttendance {
  final int batchId;
  final int subjectId;
  final String date;
  final List<int> studentId;
  final List<int> attendance;

  SaveAttendance({
    required this.batchId,
    required this.subjectId,
    required this.date,
    required this.studentId,
    required this.attendance,
  });

  factory SaveAttendance.fromJson(Map<String, dynamic> json) => SaveAttendance(
        batchId: json["batch_id"],
        subjectId: json["subject_id"],
        date: json["date"],
        studentId: List<int>.from(json["student_id"].map((x) => x)),
        attendance: List<int>.from(json["attendance"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "subject_id": subjectId,
        "date": date,
        "student_id": List<dynamic>.from(studentId.map((x) => x)),
        "attendance": List<dynamic>.from(attendance.map((x) => x)),
      };
}
