class QuestionPaperList {
  final int? currentPage;
  final List<PaperItem>? data;
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

  const QuestionPaperList({
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

  factory QuestionPaperList.fromJson(Map<String, dynamic> json) =>
      QuestionPaperList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<PaperItem>.from(
                json["data"]!.map((x) => PaperItem.fromJson(x))),
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

class PaperItem {
  final int? id;
  final String? name;
  final String? type;
  final String? datetime;
  final String? duration;
  final int? fullMark;
  final int? subjectId;
  final int? totalQuestion;
  final Subject? subject;

  const PaperItem({
    this.id,
    this.name,
    this.type,
    this.datetime,
    this.duration,
    this.fullMark,
    this.subjectId,
    this.totalQuestion,
    this.subject,
  });

  factory PaperItem.fromJson(Map<String, dynamic> json) => PaperItem(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        datetime: json["datetime"],
        duration: json["duration"],
        fullMark: json["full_mark"],
        subjectId: json["subject_id"],
        totalQuestion: json["total_question"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "datetime": datetime,
        "duration": duration,
        "full_mark": fullMark,
        "subject_id": subjectId,
        "total_question": totalQuestion,
        "subject": subject?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final int? subjectGroupId;

  const Subject({
    this.id,
    this.name,
    this.code,
    this.subjectGroupId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        subjectGroupId: json["subject_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "subject_group_id": subjectGroupId,
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
