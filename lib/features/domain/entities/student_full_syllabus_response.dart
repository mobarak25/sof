class StudentFullSyllabus {
  final List<Data>? data;

  const StudentFullSyllabus({
    this.data,
  });

  factory StudentFullSyllabus.fromJson(Map<String, dynamic> json) =>
      StudentFullSyllabus(
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  final int? id;
  final String? url;
  final String? type;
  final int? syllabusFullsyllabusIs;

  Data({
    this.id,
    this.url,
    this.type,
    this.syllabusFullsyllabusIs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        url: json["url"],
        type: json["type"],
        syllabusFullsyllabusIs: json["syllabus_fullsyllabus_is"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
        "syllabus_fullsyllabus_is": syllabusFullsyllabusIs,
      };
}
