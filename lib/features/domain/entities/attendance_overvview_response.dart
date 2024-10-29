class AttendanceOverview {
  final Data? data;

  const AttendanceOverview({
    this.data,
  });

  factory AttendanceOverview.fromJson(Map<String, dynamic> json) =>
      AttendanceOverview(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? totalStudent;
  final int? classes;
  final int? absent;
  final int? present;
  final int? leave;
  final int? late;
  final num? percentage;

  const Data({
    this.totalStudent,
    this.classes,
    this.absent,
    this.present,
    this.leave,
    this.late,
    this.percentage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalStudent: json["total_student"],
        classes: json["classes"],
        absent: json["absent"],
        present: json["present"],
        leave: json["leave"],
        late: json["late"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "total_student": totalStudent,
        "classes": classes,
        "absent": absent,
        "present": present,
        "leave": leave,
        "late": late,
        "percentage": percentage,
      };
}
