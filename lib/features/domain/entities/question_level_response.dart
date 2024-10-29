class QuestionLevel {
  final List<Data>? data;

  const QuestionLevel({this.data});

  factory QuestionLevel.fromJson(Map<String, dynamic> json) => QuestionLevel(
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
  final int? level;
  final String? levelValue;

  Data({
    this.id,
    this.level,
    this.levelValue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        level: json["level"],
        levelValue: json["level_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
        "level_value": levelValue,
      };
}
