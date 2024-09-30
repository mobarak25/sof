class NoticeResponse {
  final int? currentPage;
  final List<NoticeItem>? noticeList;
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

  const NoticeResponse({
    this.currentPage,
    this.noticeList,
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

  factory NoticeResponse.fromJson(Map<String, dynamic> json) => NoticeResponse(
        currentPage: json["current_page"],
        noticeList: json["data"] == null
            ? []
            : List<NoticeItem>.from(
                json["data"]!.map((x) => NoticeItem.fromJson(x))),
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
        "data": noticeList == null
            ? []
            : List<dynamic>.from(noticeList!.map((x) => x.toJson())),
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

class NoticeItem {
  final int? id;
  final String? title;
  final int? isCommon;
  final int? type;
  final int? status;
  final dynamic iconUrl;
  final int? isCommentable;
  final int? authorId;
  final String? createdAt;
  final String? description;
  final List<Attachment>? attachments;
  final User? user;

  NoticeItem({
    this.id,
    this.title,
    this.isCommon,
    this.type,
    this.status,
    this.iconUrl,
    this.isCommentable,
    this.authorId,
    this.createdAt,
    this.description,
    this.attachments,
    this.user,
  });

  factory NoticeItem.fromJson(Map<String, dynamic> json) => NoticeItem(
        id: json["id"],
        title: json["title"],
        isCommon: json["is_common"],
        type: json["type"],
        status: json["status"],
        iconUrl: json["icon_url"],
        isCommentable: json["is_commentable"],
        authorId: json["author_id"],
        createdAt: json["created_at"],
        description: json["description"],
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_common": isCommon,
        "type": type,
        "status": status,
        "icon_url": iconUrl,
        "is_commentable": isCommentable,
        "author_id": authorId,
        "created_at": createdAt,
        "description": description,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "user": user?.toJson(),
      };
}

class Attachment {
  final int? id;
  final int? noticeId;
  final String? file;

  Attachment({
    this.id,
    this.noticeId,
    this.file,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        noticeId: json["notice_id"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notice_id": noticeId,
        "file": file,
      };
}

class User {
  final int? id;
  final String? fullname;

  User({
    this.id,
    this.fullname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
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
