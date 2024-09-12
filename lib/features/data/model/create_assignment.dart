class CreateAssignment {
  final String title;
  final String? description;
  final String publishedAt;
  final String dueAt;
  final String subjectId;
  final int status;
  final String isMarkable;
  final List<int> assignToStudent;
  final String? marks;
  final List<int> assignToBatch;
  final int submissionRequired;
  final List<String> assignmentAttachmentUrl;

  CreateAssignment({
    required this.title,
    this.description,
    required this.publishedAt,
    required this.dueAt,
    required this.subjectId,
    required this.status,
    required this.isMarkable,
    required this.assignToStudent,
    this.marks,
    required this.assignToBatch,
    required this.submissionRequired,
    required this.assignmentAttachmentUrl,
  });

  factory CreateAssignment.fromJson(Map<String, dynamic> json) =>
      CreateAssignment(
        title: json["title"],
        description: json["description"],
        publishedAt: json["published_at"],
        dueAt: json["due_at"],
        subjectId: json["subject_id"],
        status: json["status"],
        isMarkable: json["is_markable"],
        assignToStudent: json["assign_to_student"] == null
            ? []
            : List<int>.from(json["assign_to_student"]!.map((x) => x)),
        marks: json["marks"],
        assignToBatch: json["assign_to_batch"] == null
            ? []
            : List<int>.from(json["assign_to_batch"]!.map((x) => x)),
        submissionRequired: json["submission_required"],
        assignmentAttachmentUrl: json["assignment_attachment__url"] == null
            ? []
            : List<String>.from(
                json["assignment_attachment__url"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "published_at": publishedAt,
        "due_at": dueAt,
        "subject_id": subjectId,
        "status": status,
        "is_markable": isMarkable,
        "assign_to_student": List<dynamic>.from(assignToStudent.map((x) => x)),
        "marks": marks,
        "assign_to_batch": List<dynamic>.from(assignToBatch.map((x) => x)),
        "submission_required": submissionRequired,
        "assignment_attachment__url":
            List<dynamic>.from(assignmentAttachmentUrl.map((x) => x)),
      };
}
