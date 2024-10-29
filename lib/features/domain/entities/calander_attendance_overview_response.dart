class CalanderAttendanceOverview {
  final List<CalanderDay>? data;

  const CalanderAttendanceOverview({
    this.data,
  });

  factory CalanderAttendanceOverview.fromJson(Map<String, dynamic> json) =>
      CalanderAttendanceOverview(
        data: json["data"] == null
            ? []
            : List<CalanderDay>.from(
                json["data"]!.map((x) => CalanderDay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CalanderDay {
  final int? id;
  final int? attendanceRegisterId;
  final String? date;
  final int? studentId;
  final int? presentStatus;

  const CalanderDay({
    this.id,
    this.attendanceRegisterId,
    this.date,
    this.studentId,
    this.presentStatus,
  });

  factory CalanderDay.fromJson(Map<String, dynamic> json) => CalanderDay(
        id: json["id"],
        attendanceRegisterId: json["attendance_register_id"],
        date: json["date"],
        studentId: json["student_id"],
        presentStatus: json["present_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendance_register_id": attendanceRegisterId,
        "date": date,
        "student_id": studentId,
        "present_status": presentStatus,
      };
}
