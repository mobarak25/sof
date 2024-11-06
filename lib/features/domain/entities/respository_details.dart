class RepositoryDetails {
  final Data? data;

  const RepositoryDetails({
    this.data,
  });

  factory RepositoryDetails.fromJson(Map<String, dynamic> json) =>
      RepositoryDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final String? description;
  final String? thumbnail;
  final int? totalAttachments;
  final List<Attachment>? attachments;

  const Data({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.totalAttachments,
    this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        totalAttachments: json["total_attachments"],
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "total_attachments": totalAttachments,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      };
}

class Attachment {
  final int? id;
  final String? url;
  final int? digitalRepositoryId;

  const Attachment({
    this.id,
    this.url,
    this.digitalRepositoryId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        url: json["url"],
        digitalRepositoryId: json["digital_repository_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "digital_repository_id": digitalRepositoryId,
      };
}
