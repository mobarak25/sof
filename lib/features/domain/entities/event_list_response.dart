class EventList {
  final List<EventItem>? data;

  const EventList({
    this.data,
  });

  factory EventList.fromJson(Map<String, dynamic> json) => EventList(
        data: json["data"] == null
            ? []
            : List<EventItem>.from(
                json["data"]!.map((x) => EventItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EventItem {
  final int? id;
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final int? isCommon;
  final int? isHoliday;
  final String? color;
  final int? eventCategoryId;
  final dynamic eventFile;

  EventItem({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.isCommon,
    this.isHoliday,
    this.color,
    this.eventCategoryId,
    this.eventFile,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) => EventItem(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        isCommon: json["is_common"],
        isHoliday: json["is_holiday"],
        color: json["color"],
        eventCategoryId: json["event_category_id"],
        eventFile: json["event_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "is_common": isCommon,
        "is_holiday": isHoliday,
        "color": color,
        "event_category_id": eventCategoryId,
        "event_file": eventFile,
      };
}
