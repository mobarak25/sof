class Resources {
  final int? currentPage;
  final List<ResourcesItem>? data;
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

  const Resources({
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

  factory Resources.fromJson(Map<String, dynamic> json) => Resources(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ResourcesItem>.from(
                json["data"]!.map((x) => ResourcesItem.fromJson(x))),
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

class ResourcesItem {
  final int? id;
  final String? title;
  final int? subjectId;
  final int? chapterId;
  final String? thumbnail;
  final int? resourceType;
  final Subject? subject;

  ResourcesItem({
    this.id,
    this.title,
    this.subjectId,
    this.chapterId,
    this.thumbnail,
    this.resourceType,
    this.subject,
  });

  factory ResourcesItem.fromJson(Map<String, dynamic> json) => ResourcesItem(
        id: json["id"],
        title: json["title"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        thumbnail: json["thumbnail"],
        resourceType: json["resource_type"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "thumbnail": thumbnail,
        "resource_type": resourceType,
        "subject": subject?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? imageUrl;

  Subject({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
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
