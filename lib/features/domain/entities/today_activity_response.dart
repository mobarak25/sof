class TodayActivities {
  final Data? data;

  const TodayActivities({
    this.data,
  });

  factory TodayActivities.fromJson(Map<String, dynamic> json) =>
      TodayActivities(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? totalClass;
  final int? totalEvent;
  final int? totalHomework;
  final int? totalQuiz;

  const Data({
    this.totalClass,
    this.totalEvent,
    this.totalHomework,
    this.totalQuiz,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalClass: json["total_class"],
        totalEvent: json["total_event"],
        totalHomework: json["total_homework"],
        totalQuiz: json["total_quiz"],
      );

  Map<String, dynamic> toJson() => {
        "total_class": totalClass,
        "total_event": totalEvent,
        "total_homework": totalHomework,
        "total_quiz": totalQuiz,
      };
}
