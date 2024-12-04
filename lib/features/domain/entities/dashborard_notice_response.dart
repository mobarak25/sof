class DashboardNoticeRes {
  final List<DashboardNoticeItem>? data;

  const DashboardNoticeRes({
    this.data,
  });

  factory DashboardNoticeRes.fromJson(Map<String, dynamic> json) =>
      DashboardNoticeRes(
        data: json["data"] == null
            ? []
            : List<DashboardNoticeItem>.from(
                json["data"]!.map((x) => DashboardNoticeItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DashboardNoticeItem {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? lastUpdate;
  final String? type;
  final dynamic iconUrl;

  const DashboardNoticeItem({
    this.id,
    this.title,
    this.description,
    this.lastUpdate,
    this.type,
    this.iconUrl,
  });

  factory DashboardNoticeItem.fromJson(Map<String, dynamic> json) =>
      DashboardNoticeItem(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        lastUpdate: json["last_update"] == null
            ? null
            : DateTime.parse(json["last_update"]),
        type: json["type"],
        iconUrl: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "last_update": lastUpdate?.toIso8601String(),
        "type": type,
        "icon_url": iconUrl,
      };
}
