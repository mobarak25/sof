class EventDetails {
  final Data? data;

  const EventDetails({
    this.data,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) => EventDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
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
  final Category? category;

  const Data({
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
    this.category,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
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
        "category": category?.toJson(),
      };
}

class Category {
  final int? id;
  final String? name;

  const Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
