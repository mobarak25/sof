class AbsentStudents {
  final List<AbsentItem>? data;

  const AbsentStudents({
    this.data,
  });

  factory AbsentStudents.fromJson(Map<String, dynamic> json) => AbsentStudents(
        data: json["data"] == null
            ? []
            : List<AbsentItem>.from(
                json["data"]!.map((x) => AbsentItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AbsentItem {
  final int? studentId;
  final String? versionName;
  final String? className;
  final String? sectionName;
  final String? fullName;
  final String? imageUrl;
  final String? classRollNo;
  final String? lastAttendance;
  final String? today;
  final int? absentInDays;

  const AbsentItem({
    this.studentId,
    this.versionName,
    this.className,
    this.sectionName,
    this.fullName,
    this.imageUrl,
    this.classRollNo,
    this.lastAttendance,
    this.today,
    this.absentInDays,
  });

  factory AbsentItem.fromJson(Map<String, dynamic> json) => AbsentItem(
        studentId: json["student_id"],
        versionName: json["version_name"],
        className: json["class_name"],
        sectionName: json["section_name"],
        fullName: json["full_name"],
        imageUrl: json["image_url"],
        classRollNo: json["class_roll_no"],
        lastAttendance: json["last_attendance"],
        today: json["today"],
        absentInDays: json["absent_in_days"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "version_name": versionName,
        "class_name": className,
        "section_name": sectionName,
        "full_name": fullName,
        "image_url": imageUrl,
        "class_roll_no": classRollNo,
        "last_attendance": lastAttendance,
        "today": today,
        "absent_in_days": absentInDays,
      };
}
