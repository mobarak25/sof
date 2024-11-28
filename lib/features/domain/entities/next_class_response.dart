class NextClass {
  final Data? data;

  const NextClass({
    this.data,
  });

  factory NextClass.fromJson(Map<String, dynamic> json) => NextClass(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? batchId;
  final int? subjectId;
  final String? subjectName;
  final String? imageUrl;
  final int? subjectGroupId;
  final String? weekdayName;
  final String? startTime;
  final String? endTime;
  final dynamic isBreak;
  final String? roomNo;

  const Data({
    this.batchId,
    this.subjectId,
    this.subjectName,
    this.imageUrl,
    this.subjectGroupId,
    this.weekdayName,
    this.startTime,
    this.endTime,
    this.isBreak,
    this.roomNo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        batchId: json["batch_id"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
        weekdayName: json["weekday_name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        isBreak: json["is_break"],
        roomNo: json["room_no"],
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "subject_id": subjectId,
        "subject_name": subjectName,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
        "weekday_name": weekdayName,
        "start_time": startTime,
        "end_time": endTime,
        "is_break": isBreak,
        "room_no": roomNo,
      };
}
