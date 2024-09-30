class LessonPlan {
  final int? currentPage;
  final List<PlanItem>? data;
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

  const LessonPlan({
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

  factory LessonPlan.fromJson(Map<String, dynamic> json) => LessonPlan(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<PlanItem>.from(
                json["data"]!.map((x) => PlanItem.fromJson(x))),
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

class PlanItem {
  final int? id;
  final String? title;
  final int? status;
  final Subject? subject;
  final int? attachments;
  final int? resources;
  final Class? version;
  final Class? datumClass;
  final Class? section;
  final Batch? batch;

  const PlanItem({
    this.id,
    this.title,
    this.status,
    this.subject,
    this.attachments,
    this.resources,
    this.version,
    this.datumClass,
    this.section,
    this.batch,
  });

  factory PlanItem.fromJson(Map<String, dynamic> json) => PlanItem(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        attachments: json["attachments"],
        resources: json["resources"],
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        datumClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
        section:
            json["section"] == null ? null : Class.fromJson(json["section"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "subject": subject?.toJson(),
        "attachments": attachments,
        "resources": resources,
        "version": version?.toJson(),
        "class": datumClass?.toJson(),
        "section": section?.toJson(),
        "batch": batch?.toJson(),
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? sectionId;
  final Class? section;

  const Batch({
    this.id,
    this.name,
    this.sectionId,
    this.section,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
        sectionId: json["section_id"],
        section:
            json["section"] == null ? null : Class.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "section_id": sectionId,
        "section": section?.toJson(),
      };
}

class Class {
  final int? id;
  final String? name;

  const Class({
    this.id,
    this.name,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
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

  const Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  const Link({
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
