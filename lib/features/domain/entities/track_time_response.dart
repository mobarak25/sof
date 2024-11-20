class TrackTime {
  final int? data;

  const TrackTime({
    this.data,
  });

  factory TrackTime.fromJson(Map<String, dynamic> json) => TrackTime(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
