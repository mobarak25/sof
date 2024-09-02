class StudentAssignmentDetails {
  final Data? data;

  const StudentAssignmentDetails({
    this.data,
  });

  factory StudentAssignmentDetails.fromJson(Map<String, dynamic> json) =>
      StudentAssignmentDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? assignmentStudentId;
  final int? submissionStatus;
  final String? content;
  final int? isDraft;
  final String? marks;
  final int? totalFeedbacks;
  final StudentAssignment? studentAssignment;
  final List<Attachment>? attachments;

  Data({
    this.id,
    this.assignmentStudentId,
    this.submissionStatus,
    this.content,
    this.isDraft,
    this.marks,
    this.totalFeedbacks,
    this.studentAssignment,
    this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        assignmentStudentId: json["assignment_student_id"],
        submissionStatus: json["submission_status"],
        content: json["content"],
        isDraft: json["is_draft"],
        marks: json["marks"],
        totalFeedbacks: json["total_feedbacks"],
        studentAssignment: json["student_assignment"] == null
            ? null
            : StudentAssignment.fromJson(json["student_assignment"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_student_id": assignmentStudentId,
        "submission_status": submissionStatus,
        "content": content,
        "is_draft": isDraft,
        "marks": marks,
        "total_feedbacks": totalFeedbacks,
        "student_assignment": studentAssignment?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      };
}

class Attachment {
  final int? id;
  final int? studentAssignmentSubId;
  final String? url;
  final String? type;

  Attachment({
    this.id,
    this.studentAssignmentSubId,
    this.url,
    this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        studentAssignmentSubId: json["student_assignment_sub_id"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_assignment_sub_id": studentAssignmentSubId,
        "url": url,
        "type": type,
      };
}

class StudentAssignment {
  final int? id;
  final int? assignmentId;
  final int? studentId;
  final int? submissionStatus;
  final dynamic lateSubmissionDate;
  final Student? student;
  final Assignment? assignment;

  StudentAssignment({
    this.id,
    this.assignmentId,
    this.studentId,
    this.submissionStatus,
    this.lateSubmissionDate,
    this.student,
    this.assignment,
  });

  factory StudentAssignment.fromJson(Map<String, dynamic> json) =>
      StudentAssignment(
        id: json["id"],
        assignmentId: json["assignment_id"],
        studentId: json["student_id"],
        submissionStatus: json["submission_status"],
        lateSubmissionDate: json["late_submission_date"],
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
        assignment: json["assignment"] == null
            ? null
            : Assignment.fromJson(json["assignment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_id": assignmentId,
        "student_id": studentId,
        "submission_status": submissionStatus,
        "late_submission_date": lateSubmissionDate,
        "student": student?.toJson(),
        "assignment": assignment?.toJson(),
      };
}

class Assignment {
  final int? id;
  final String? title;
  final int? subjectId;
  final int? daysLeft;
  final Subject? subject;

  Assignment({
    this.id,
    this.title,
    this.subjectId,
    this.daysLeft,
    this.subject,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"],
        title: json["title"],
        subjectId: json["subject_id"],
        daysLeft: json["days_left"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subject_id": subjectId,
        "days_left": daysLeft,
        "subject": subject?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;

  Subject({
    this.id,
    this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Student {
  final int? id;
  final String? firstName;
  final dynamic middleName;
  final dynamic lastName;
  final String? imageUrl;
  final dynamic classRollNo;
  final String? admissionNumber;
  final String? fullName;

  Student({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imageUrl,
    this.classRollNo,
    this.admissionNumber,
    this.fullName,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        imageUrl: json["image_url"],
        classRollNo: json["class_roll_no"],
        admissionNumber: json["admission_number"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "image_url": imageUrl,
        "class_roll_no": classRollNo,
        "admission_number": admissionNumber,
        "full_name": fullName,
      };
}
