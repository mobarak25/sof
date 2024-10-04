class SyllabusTeacher {
  final int? currentPage;
  final List<SyllabusClassQuizTest>? data;
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

  const SyllabusTeacher({
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

  factory SyllabusTeacher.fromJson(Map<String, dynamic> json) =>
      SyllabusTeacher(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<SyllabusClassQuizTest>.from(
                json["data"]!.map((x) => SyllabusClassQuizTest.fromJson(x))),
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

class SyllabusClassQuizTest {
  final int? id;
  final String? title;
  final dynamic content;
  final String? date;
  final int? versionId;
  final int? classId;
  final int? sectionId;
  final int? subjectId;
  final String? type;
  final int? status;
  final int? mark;
  final int? authorId;
  final Subject? subject;
  final Batch? batch;
  final dynamic datumClass;

  SyllabusClassQuizTest({
    this.id,
    this.title,
    this.content,
    this.date,
    this.versionId,
    this.classId,
    this.sectionId,
    this.subjectId,
    this.type,
    this.status,
    this.mark,
    this.authorId,
    this.subject,
    this.batch,
    this.datumClass,
  });

  factory SyllabusClassQuizTest.fromJson(Map<String, dynamic> json) =>
      SyllabusClassQuizTest(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        date: json["date"],
        versionId: json["version_id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        subjectId: json["subject_id"],
        type: json["type"],
        status: json["status"],
        mark: json["mark"],
        authorId: json["author_id"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        datumClass: json["class"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "date": date,
        "version_id": versionId,
        "class_id": classId,
        "section_id": sectionId,
        "subject_id": subjectId,
        "type": type,
        "status": status,
        "mark": mark,
        "author_id": authorId,
        "subject": subject?.toJson(),
        "batch": batch?.toJson(),
        "class": datumClass,
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? sectionId;
  final Section? section;

  Batch({
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
            json["section"] == null ? null : Section.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "section_id": sectionId,
        "section": section?.toJson(),
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

class Subject {
  final int? id;
  final String? name;
  final String? imageUrl;
  final int? subjectGroupId;

  Subject({
    this.id,
    this.name,
    this.imageUrl,
    this.subjectGroupId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
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
