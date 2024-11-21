class QuizStudents {
  final int? currentPage;
  final List<QuizStudentItem>? data;
  final int? lastPage;
  final int? total;

  const QuizStudents({
    this.currentPage,
    this.data,
    this.lastPage,
    this.total,
  });

  factory QuizStudents.fromJson(Map<String, dynamic> json) => QuizStudents(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<QuizStudentItem>.from(
                json["data"]!.map((x) => QuizStudentItem.fromJson(x))),
        lastPage: json["last_page"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "last_page": lastPage,
        "total": total,
      };
}

class QuizStudentItem {
  final int? id;
  final int? studentId;
  final int? isFinalSubmit;
  final QuizTime? quizTime;
  final Student? student;

  const QuizStudentItem({
    this.id,
    this.studentId,
    this.isFinalSubmit,
    this.quizTime,
    this.student,
  });

  factory QuizStudentItem.fromJson(Map<String, dynamic> json) =>
      QuizStudentItem(
        id: json["id"],
        studentId: json["student_id"],
        isFinalSubmit: json["is_final_submit"],
        quizTime: json["quiz_time"] == null
            ? null
            : QuizTime.fromJson(json["quiz_time"]),
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "is_final_submit": isFinalSubmit,
        "quiz_time": quizTime?.toJson(),
        "student": student?.toJson(),
      };
}

class QuizTime {
  final int? quizId;
  final int? studentId;
  final int? obtainedMark;
  final int? endStatus;
  final dynamic isReviewed;

  QuizTime({
    this.quizId,
    this.studentId,
    this.obtainedMark,
    this.endStatus,
    this.isReviewed,
  });

  factory QuizTime.fromJson(Map<String, dynamic> json) => QuizTime(
        quizId: json["quiz_id"],
        studentId: json["student_id"],
        obtainedMark: json["obtained_mark"],
        endStatus: json["end_status"],
        isReviewed: json["is_reviewed"],
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "student_id": studentId,
        "obtained_mark": obtainedMark,
        "end_status": endStatus,
        "is_reviewed": isReviewed,
      };
}

class Student {
  final int? id;
  final String? firstName;
  final dynamic middleName;
  final dynamic lastName;
  final String? imageUrl;
  final String? admissionNumber;
  final String? classRollNo;
  final String? fullName;

  Student({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imageUrl,
    this.admissionNumber,
    this.classRollNo,
    this.fullName,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        imageUrl: json["image_url"],
        admissionNumber: json["admission_number"],
        classRollNo: json["class_roll_no"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "image_url": imageUrl,
        "admission_number": admissionNumber,
        "class_roll_no": classRollNo,
        "full_name": fullName,
      };
}
