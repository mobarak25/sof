class AssignmentFeedback {
  final int? currentPage;
  final List<FeedbackItem>? data;
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

  const AssignmentFeedback({
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

  factory AssignmentFeedback.fromJson(Map<String, dynamic> json) =>
      AssignmentFeedback(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<FeedbackItem>.from(
                json["data"]!.map((x) => FeedbackItem.fromJson(x))),
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

class FeedbackItem {
  final int? id;
  final DateTime? lateSubmissionDate;
  final String? content;
  final String? createdAt;
  final Author? author;

  FeedbackItem({
    this.id,
    this.lateSubmissionDate,
    this.content,
    this.createdAt,
    this.author,
  });

  factory FeedbackItem.fromJson(Map<String, dynamic> json) => FeedbackItem(
        id: json["id"],
        lateSubmissionDate: json["late_submission_date"] == null
            ? null
            : DateTime.parse(json["late_submission_date"]),
        content: json["content"],
        createdAt: json["created_at"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "late_submission_date": lateSubmissionDate?.toIso8601String(),
        "content": content,
        "created_at": createdAt,
        "author": author?.toJson(),
      };
}

class Author {
  final int? id;
  final String? fullname;
  final String? image;

  Author({
    this.id,
    this.fullname,
    this.image,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        fullname: json["fullname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "image": image,
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
