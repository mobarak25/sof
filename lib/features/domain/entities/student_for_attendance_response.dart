class StudentsForAttendance {
  final List<StudentInfo>? data;

  const StudentsForAttendance({
    this.data,
  });

  factory StudentsForAttendance.fromJson(Map<String, dynamic> json) =>
      StudentsForAttendance(
        data: json["data"] == null
            ? []
            : List<StudentInfo>.from(
                json["data"]!.map((x) => StudentInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StudentInfo {
  final int? id;
  final int? userId;
  final int? batchId;
  final String? imageUrl;
  final String? firstName;
  final dynamic middleName;
  final dynamic lastName;
  final String? classRollNo;
  final String? admissionNumber;
  final dynamic attendanceStatus;
  final String? fullName;

  const StudentInfo({
    this.id,
    this.userId,
    this.batchId,
    this.imageUrl,
    this.firstName,
    this.middleName,
    this.lastName,
    this.classRollNo,
    this.admissionNumber,
    this.attendanceStatus,
    this.fullName,
  });

  factory StudentInfo.fromJson(Map<String, dynamic> json) => StudentInfo(
        id: json["id"],
        userId: json["user_id"],
        batchId: json["batch_id"],
        imageUrl: json["image_url"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        classRollNo: json["class_roll_no"],
        admissionNumber: json["admission_number"],
        attendanceStatus: json["attendance_status"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "batch_id": batchId,
        "image_url": imageUrl,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "class_roll_no": classRollNo,
        "admission_number": admissionNumber,
        "attendance_status": attendanceStatus,
        "full_name": fullName,
      };
}
