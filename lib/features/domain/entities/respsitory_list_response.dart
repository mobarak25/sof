class Repositories {
  final int? currentPage;
  final List<RepositoryItem>? data;
  final int? lastPage;

  const Repositories({
    this.currentPage,
    this.data,
    this.lastPage,
  });

  factory Repositories.fromJson(Map<String, dynamic> json) => Repositories(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<RepositoryItem>.from(
                json["data"]!.map((x) => RepositoryItem.fromJson(x))),
        lastPage: json["last_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "last_page": lastPage,
      };
}

class RepositoryItem {
  final int? id;
  final String? title;
  final String? description;
  final String? thumbnail;
  final int? totalAttachments;

  RepositoryItem({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.totalAttachments,
  });

  factory RepositoryItem.fromJson(Map<String, dynamic> json) => RepositoryItem(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        totalAttachments: json["total_attachments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "total_attachments": totalAttachments,
      };
}
