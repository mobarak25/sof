class AssignmentDetails {
  final Data? data;

  const AssignmentDetails({
    this.data,
  });

  factory AssignmentDetails.fromJson(Map<String, dynamic> json) =>
      AssignmentDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final String? description;
  final int? marks;
  final int? obtainedMark;
  final int? status;
  final int? countAssignToStudent;
  final int? countSubmittedByStudent;
  final int? countViewedAssignment;
  final String? publishedAt;
  final String? dueAt;
  final int? daysLeft;
  final dynamic isMarkable;
  final Subject? subject;
  final List<Attachment>? attachments;
  final List<Section>? sections;
  final AssignStudent? assignStudent;

  Data({
    this.id,
    this.title,
    this.description,
    this.marks,
    this.obtainedMark,
    this.status,
    this.countAssignToStudent,
    this.countSubmittedByStudent,
    this.countViewedAssignment,
    this.publishedAt,
    this.dueAt,
    this.daysLeft,
    this.isMarkable,
    this.subject,
    this.attachments,
    this.sections,
    this.assignStudent,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        marks: json["marks"],
        obtainedMark: json["obtained_mark"],
        status: json["status"],
        countAssignToStudent: json["count_assign_to_student"],
        countSubmittedByStudent: json["count_submitted_by_student"],
        countViewedAssignment: json["count_viewed_assignment"],
        publishedAt: json["published_at"],
        dueAt: json["due_at"],
        daysLeft: json["days_left"],
        isMarkable: json["is_markable"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
        assignStudent: json["assign_student"] == null
            ? null
            : AssignStudent.fromJson(json["assign_student"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "marks": marks,
        "obtained_mark": obtainedMark,
        "status": status,
        "count_assign_to_student": countAssignToStudent,
        "count_submitted_by_student": countSubmittedByStudent,
        "count_viewed_assignment": countViewedAssignment,
        "published_at": publishedAt,
        "due_at": dueAt,
        "days_left": daysLeft,
        "is_markable": isMarkable,
        "subject": subject?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "assign_student": assignStudent?.toJson(),
      };
}

class AssignStudent {
  final int? id;
  final int? studentId;
  final int? assignmentId;
  final int? submissionStatus;
  final dynamic lateSubmissionDate;
  final AssignmentSubmission? assignmentSubmission;

  const AssignStudent({
    this.id,
    this.studentId,
    this.assignmentId,
    this.submissionStatus,
    this.lateSubmissionDate,
    this.assignmentSubmission,
  });

  factory AssignStudent.fromJson(Map<String, dynamic> json) => AssignStudent(
        id: json["id"],
        studentId: json["student_id"],
        assignmentId: json["assignment_id"],
        submissionStatus: json["submission_status"],
        lateSubmissionDate: json["late_submission_date"],
        assignmentSubmission: json["assignment_submission"] == null
            ? null
            : AssignmentSubmission.fromJson(json["assignment_submission"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "assignment_id": assignmentId,
        "submission_status": submissionStatus,
        "late_submission_date": lateSubmissionDate,
        "assignment_submission": assignmentSubmission?.toJson(),
      };
}

class AssignmentSubmission {
  final int? id;
  final String? marks;
  final int? assignmentStudentId;
  final int? submissionStatus;
  final int? isDraft;
  final String? content;
  final int? totalFeedbacks;

  AssignmentSubmission({
    this.id,
    this.marks,
    this.assignmentStudentId,
    this.submissionStatus,
    this.isDraft,
    this.content,
    this.totalFeedbacks,
  });

  factory AssignmentSubmission.fromJson(Map<String, dynamic> json) =>
      AssignmentSubmission(
        id: json["id"],
        marks: json["marks"],
        assignmentStudentId: json["assignment_student_id"],
        submissionStatus: json["submission_status"],
        isDraft: json["is_draft"],
        content: json["content"],
        totalFeedbacks: json["total_feedbacks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "marks": marks,
        "assignment_student_id": assignmentStudentId,
        "submission_status": submissionStatus,
        "is_draft": isDraft,
        "content": content,
        "total_feedbacks": totalFeedbacks,
      };
}

class Attachment {
  final int? id;
  final int? assignmentId;
  final String? url;
  final String? type;

  const Attachment({
    this.id,
    this.assignmentId,
    this.url,
    this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        assignmentId: json["assignment_id"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_id": assignmentId,
        "url": url,
        "type": type,
      };
}

class Section {
  final int? id;
  final String? name;

  const Section({
    this.id,
    this.name,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? subjectGroupId;
  final Section? subjectGroup;

  Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.subjectGroupId,
    this.subjectGroup,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
        subjectGroup: json["subject_group"] == null
            ? null
            : Section.fromJson(json["subject_group"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
        "subject_group": subjectGroup?.toJson(),
      };
}
