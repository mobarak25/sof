class TodayAttendanceStatus {
  final Data? data;

  const TodayAttendanceStatus({
    this.data,
  });

  factory TodayAttendanceStatus.fromJson(Map<String, dynamic> json) =>
      TodayAttendanceStatus(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final String? date;
  final dynamic presentStatus;

  const Data({
    this.date,
    this.presentStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        date: json["date"],
        presentStatus: json["present_status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "present_status": presentStatus,
      };
}
