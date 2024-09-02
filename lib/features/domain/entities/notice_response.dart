class NoticeResponse {
  final int? currentPage;
  final List<NoticeItem>? noticeList;
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
  final int? categoryId;
  final String? description;
  final int? isCommon;
  final int? type;
  final int? status;
  final dynamic iconUrl;
  final int? isCommentable;
  final int? authorId;
  final String? authorName;
  final String? createdAt;

  NoticeItem({
    this.id,
    this.title,
    this.categoryId,
    this.description,
    this.isCommon,
    this.type,
    this.status,
    this.iconUrl,
    this.isCommentable,
    this.authorId,
    this.authorName,
    this.createdAt,
  });

  factory NoticeItem.fromJson(Map<String, dynamic> json) => NoticeItem(
        id: json["id"],
        title: json["title"],
        categoryId: json["category_id"],
        description: json["description"],
        isCommon: json["is_common"],
        type: json["type"],
        status: json["status"],
        iconUrl: json["icon_url"],
        isCommentable: json["is_commentable"],
        authorId: json["author_id"],
        authorName: json["author_name"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category_id": categoryId,
        "description": description,
        "is_common": isCommon,
        "type": type,
        "status": status,
        "icon_url": iconUrl,
        "is_commentable": isCommentable,
        "author_id": authorId,
        "author_name": authorName,
        "created_at": createdAt,
      };
}

class Link {
  final dynamic url;
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
