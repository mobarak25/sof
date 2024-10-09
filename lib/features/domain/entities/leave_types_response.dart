class LeaveTypes {
  final List<LeaveType>? data;

  const LeaveTypes({
    this.data,
  });

  factory LeaveTypes.fromJson(Map<String, dynamic> json) => LeaveTypes(
        data: json["data"] == null
            ? []
            : List<LeaveType>.from(
                json["data"]!.map((x) => LeaveType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class LeaveType {
  final int? id;
  final String? name;

  LeaveType({
    this.id,
    this.name,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
