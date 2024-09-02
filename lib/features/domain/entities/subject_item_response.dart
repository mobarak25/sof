class SubjectResponse {
  final List<SubjectItem>? data;

  SubjectResponse({
    this.data,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) =>
      SubjectResponse(
        data: json["data"] == null
            ? []
            : List<SubjectItem>.from(
                json["data"]!.map((x) => SubjectItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubjectItem {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? subjectGroupId;

  SubjectItem({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.subjectGroupId,
  });

  factory SubjectItem.fromJson(Map<String, dynamic> json) => SubjectItem(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
      };
}
