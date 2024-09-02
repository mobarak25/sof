class ProfileAttendanceResponse {
  final Data? data;

  const ProfileAttendanceResponse({
    this.data,
  });

  factory ProfileAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      ProfileAttendanceResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final CurrentMonthAttendance? currentMonthAttendance;
  final List<CurrentMonthAttendance>? monthlyReview;

  Data({
    this.currentMonthAttendance,
    this.monthlyReview,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentMonthAttendance: json["current_month_attendance"] == null
            ? null
            : CurrentMonthAttendance.fromJson(json["current_month_attendance"]),
        monthlyReview: json["monthly_review"] == null
            ? []
            : List<CurrentMonthAttendance>.from(json["monthly_review"]!
                .map((x) => CurrentMonthAttendance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_month_attendance": currentMonthAttendance?.toJson(),
        "monthly_review": monthlyReview == null
            ? []
            : List<dynamic>.from(monthlyReview!.map((x) => x.toJson())),
      };
}

class CurrentMonthAttendance {
  final String? studentId;
  final int? absent;
  final int? present;
  final int? leaveCount;
  final int? late;
  final String? monthNumber;
  final String? monthName;

  const CurrentMonthAttendance({
    this.studentId,
    this.absent,
    this.present,
    this.leaveCount,
    this.late,
    this.monthNumber,
    this.monthName,
  });

  factory CurrentMonthAttendance.fromJson(Map<String, dynamic> json) =>
      CurrentMonthAttendance(
        studentId: json["student_id"],
        absent: json["absent"],
        present: json["present"],
        leaveCount: json["leave_count"],
        late: json["late"],
        monthNumber: json["month_number"],
        monthName: json["month_name"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "absent": absent,
        "present": present,
        "leave_count": leaveCount,
        "late": late,
        "month_number": monthNumber,
        "month_name": monthName,
      };
}
