class ExamGroupAntTermList {
  final List<GroupItem>? data;

  const ExamGroupAntTermList({
    this.data,
  });

  factory ExamGroupAntTermList.fromJson(Map<String, dynamic> json) =>
      ExamGroupAntTermList(
        data: json["data"] == null
            ? []
            : List<GroupItem>.from(
                json["data"]!.map((x) => GroupItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GroupItem {
  final int? id;
  final String? name;

  GroupItem({
    this.id,
    this.name,
  });

  factory GroupItem.fromJson(Map<String, dynamic> json) => GroupItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
