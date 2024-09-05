class TeacherSummitedAssinentView {
  final int? currentPage;
  final List<SubmittedStudent>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  const TeacherSummitedAssinentView({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory TeacherSummitedAssinentView.fromJson(Map<String, dynamic> json) =>
      TeacherSummitedAssinentView(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<SubmittedStudent>.from(
                json["data"]!.map((x) => SubmittedStudent.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class SubmittedStudent {
  final int? id;
  final String? fullName;
  final String? admissionNumber;
  final dynamic classRollNo;
  final String? imageUrl;
  final Submission? submission;

  const SubmittedStudent({
    this.id,
    this.fullName,
    this.admissionNumber,
    this.classRollNo,
    this.imageUrl,
    this.submission,
  });

  factory SubmittedStudent.fromJson(Map<String, dynamic> json) =>
      SubmittedStudent(
        id: json["id"],
        fullName: json["full_name"],
        admissionNumber: json["admission_number"],
        classRollNo: json["class_roll_no"],
        imageUrl: json["image_url"],
        submission: json["submission"] == null
            ? null
            : Submission.fromJson(json["submission"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "admission_number": admissionNumber,
        "class_roll_no": classRollNo,
        "image_url": imageUrl,
        "submission": submission?.toJson(),
      };
}

class Submission {
  final int? id;
  final int? assignmentStudentId;
  final int? submissionStatus;
  final String? content;
  final int? isDraft;
  final String? marks;
  final int? totalFeedbacks;

  const Submission({
    this.id,
    this.assignmentStudentId,
    this.submissionStatus,
    this.content,
    this.isDraft,
    this.marks,
    this.totalFeedbacks,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json["id"],
        assignmentStudentId: json["assignment_student_id"],
        submissionStatus: json["submission_status"],
        content: json["content"],
        isDraft: json["is_draft"],
        marks: json["marks"],
        totalFeedbacks: json["total_feedbacks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assignment_student_id": assignmentStudentId,
        "submission_status": submissionStatus,
        "content": content,
        "is_draft": isDraft,
        "marks": marks,
        "total_feedbacks": totalFeedbacks,
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
