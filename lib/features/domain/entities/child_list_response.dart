class ChildListResponse {
  final List<ChildItem>? data;

  const ChildListResponse({
    this.data,
  });

  factory ChildListResponse.fromJson(Map<String, dynamic> json) =>
      ChildListResponse(
        data: json["data"] == null
            ? []
            : List<ChildItem>.from(
                json["data"]!.map((x) => ChildItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChildItem {
  final int? id;
  final int? userId;
  final String? classRollNo;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? batchName;
  final String? versionName;
  final String? className;
  final String? sectionName;
  final String? imageUrl;

  ChildItem({
    this.id,
    this.userId,
    this.classRollNo,
    this.firstName,
    this.middleName,
    this.lastName,
    this.batchName,
    this.versionName,
    this.className,
    this.sectionName,
    this.imageUrl,
  });

  factory ChildItem.fromJson(Map<String, dynamic> json) => ChildItem(
        id: json["id"],
        userId: json["user_id"],
        classRollNo: json["class_roll_no"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        batchName: json["batch_name"],
        versionName: json["version_name"],
        className: json["class_name"],
        sectionName: json["section_name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_roll_no": classRollNo,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "batch_name": batchName,
        "version_name": versionName,
        "class_name": className,
        "section_name": sectionName,
        "image_url": imageUrl,
      };
}
