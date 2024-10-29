class QuestionBankList {
  final int? currentPage;
  final List<QuestionItem>? data;
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

  const QuestionBankList({
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

  factory QuestionBankList.fromJson(Map<String, dynamic> json) =>
      QuestionBankList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<QuestionItem>.from(
                json["data"]!.map((x) => QuestionItem.fromJson(x))),
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

class QuestionItem {
  final int? id;
  final String? title;
  final int? mark;
  final int? subjectId;
  final int? questionLevelId;
  final int? type;
  final Subject? subject;
  final Level? level;

  QuestionItem({
    this.id,
    this.title,
    this.mark,
    this.subjectId,
    this.questionLevelId,
    this.type,
    this.subject,
    this.level,
  });

  factory QuestionItem.fromJson(Map<String, dynamic> json) => QuestionItem(
        id: json["id"],
        title: json["title"],
        mark: json["mark"],
        subjectId: json["subject_id"],
        questionLevelId: json["question_level_id"],
        type: json["type"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "mark": mark,
        "subject_id": subjectId,
        "question_level_id": questionLevelId,
        "type": type,
        "subject": subject?.toJson(),
        "level": level?.toJson(),
      };
}

class Level {
  final int? id;
  final String? levelValue;

  Level({
    this.id,
    this.levelValue,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        levelValue: json["level_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level_value": levelValue,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? classId;
  final int? versionId;
  final Class? version;
  final Class? subjectClass;

  Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.classId,
    this.versionId,
    this.version,
    this.subjectClass,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
        classId: json["class_id"],
        versionId: json["version_id"],
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        subjectClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
        "class_id": classId,
        "version_id": versionId,
        "version": version?.toJson(),
        "class": subjectClass?.toJson(),
      };
}

class Class {
  final int? id;
  final String? name;

  Class({
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
