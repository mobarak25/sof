class ClassworkList {
  final int? currentPage;
  final List<ClassworkItem>? data;
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

  const ClassworkList({
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

  factory ClassworkList.fromJson(Map<String, dynamic> json) => ClassworkList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ClassworkItem>.from(
                json["data"]!.map((x) => ClassworkItem.fromJson(x))),
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

class ClassworkItem {
  final int? id;
  final String? title;
  final int? status;
  final String? publishedAt;
  final Subject? subject;
  final int? attachments;

  ClassworkItem({
    this.id,
    this.title,
    this.status,
    this.publishedAt,
    this.subject,
    this.attachments,
  });

  factory ClassworkItem.fromJson(Map<String, dynamic> json) => ClassworkItem(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        publishedAt: json["published_at"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        attachments: json["attachments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "published_at": publishedAt,
        "subject": subject?.toJson(),
        "attachments": attachments,
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
