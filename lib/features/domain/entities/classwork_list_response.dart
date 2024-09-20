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
  final String? shortDescription;
  final int? classId;
  final String? datumClass;
  final String? subject;
  final int? subjectId;
  final String? subjectImageUrl;
  final int? subjectGroupId;
  final List<Section>? sections;
  final List<String>? attachment;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  ClassworkItem({
    this.id,
    this.title,
    this.status,
    this.publishedAt,
    this.shortDescription,
    this.classId,
    this.datumClass,
    this.subject,
    this.subjectId,
    this.subjectImageUrl,
    this.subjectGroupId,
    this.sections,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ClassworkItem.fromJson(Map<String, dynamic> json) => ClassworkItem(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        publishedAt: json["published_at"],
        shortDescription: json["short_description"],
        classId: json["class_id"],
        datumClass: json["class"],
        subject: json["subject"],
        subjectId: json["subject_id"],
        subjectImageUrl: json["subject_image_url"],
        subjectGroupId: json["subject_group_id"],
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
        attachment: json["attachment"] == null
            ? []
            : List<String>.from(json["attachment"]!.map((x) => x)),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "published_at": publishedAt,
        "short_description": shortDescription,
        "class_id": classId,
        "class": datumClass,
        "subject": subject,
        "subject_id": subjectId,
        "subject_image_url": subjectImageUrl,
        "subject_group_id": subjectGroupId,
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "attachment": attachment == null
            ? []
            : List<dynamic>.from(attachment!.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class Section {
  final int? id;
  final String? name;

  Section({
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
