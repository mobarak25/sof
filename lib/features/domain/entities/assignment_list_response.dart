class AssignmentResponse {
  final int? currentPage;
  final List<AssignmentItem>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  const AssignmentResponse({
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

  factory AssignmentResponse.fromJson(Map<String, dynamic> json) =>
      AssignmentResponse(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<AssignmentItem>.from(
                json["data"]!.map((x) => AssignmentItem.fromJson(x))),
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

class AssignmentItem {
  final int? id;
  final String? title;
  final int? marks;
  final int? isSubmitable;
  final String? publishedAt;
  final String? dueAt;
  final int? subjectId;
  final int? status;
  final dynamic submissionStatus;
  final int? daysLeft;
  final Subject? subject;

  AssignmentItem({
    this.id,
    this.title,
    this.marks,
    this.isSubmitable,
    this.publishedAt,
    this.dueAt,
    this.subjectId,
    this.status,
    this.submissionStatus,
    this.daysLeft,
    this.subject,
  });

  factory AssignmentItem.fromJson(Map<String, dynamic> json) => AssignmentItem(
        id: json["id"],
        title: json["title"],
        marks: json["marks"],
        isSubmitable: json["is_submitable"],
        publishedAt: json["published_at"],
        dueAt: json["due_at"],
        subjectId: json["subject_id"],
        status: json["status"],
        submissionStatus: json["submission_status"],
        daysLeft: json["days_left"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "marks": marks,
        "is_submitable": isSubmitable,
        "published_at": publishedAt,
        "due_at": dueAt,
        "subject_id": subjectId,
        "status": status,
        "submission_status": submissionStatus,
        "days_left": daysLeft,
        "subject": subject?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? subjectGroupId;
  final SubjectGroup? subjectGroup;

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
            : SubjectGroup.fromJson(json["subject_group"]),
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

class SubjectGroup {
  final int? id;
  final String? name;

  SubjectGroup({
    this.id,
    this.name,
  });

  factory SubjectGroup.fromJson(Map<String, dynamic> json) => SubjectGroup(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
