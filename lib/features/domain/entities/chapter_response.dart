class Chapter {
  final List<ChapterItem>? data;

  const Chapter({
    this.data,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        data: json["data"] == null
            ? []
            : List<ChapterItem>.from(
                json["data"]!.map((x) => ChapterItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChapterItem {
  final int? id;
  final String? name;
  final int? subjectId;

  const ChapterItem({
    this.id,
    this.name,
    this.subjectId,
  });

  factory ChapterItem.fromJson(Map<String, dynamic> json) => ChapterItem(
        id: json["id"],
        name: json["name"],
        subjectId: json["subject_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subject_id": subjectId,
      };
}
