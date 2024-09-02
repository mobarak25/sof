class DueTaskResponse {
  final List<TaskItem>? data;

  const DueTaskResponse({
    this.data,
  });

  factory DueTaskResponse.fromJson(Map<String, dynamic> json) =>
      DueTaskResponse(
        data: json["data"] == null
            ? []
            : List<TaskItem>.from(
                json["data"]!.map((x) => TaskItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TaskItem {
  final int? id;
  final String? title;
  final String? desctioption;
  final String? lastUpdate;
  final String? type;
  final String? startDate;
  final String? endDate;
  final String? description;

  TaskItem({
    this.id,
    this.title,
    this.desctioption,
    this.lastUpdate,
    this.type,
    this.startDate,
    this.endDate,
    this.description,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
        id: json["id"],
        title: json["title"],
        desctioption: json["desctioption"],
        lastUpdate: json["last_update"],
        type: json["type"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desctioption": desctioption,
        "last_update": lastUpdate,
        "type": type,
        "start_date": startDate,
        "end_date": endDate,
        "description": description,
      };
}
