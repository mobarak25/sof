class FullSyllabusTeacher {
  final List<TeacherSyllabusItem>? data;

  const FullSyllabusTeacher({
    this.data,
  });

  factory FullSyllabusTeacher.fromJson(Map<String, dynamic> json) =>
      FullSyllabusTeacher(
        data: json["data"] == null
            ? []
            : List<TeacherSyllabusItem>.from(
                json["data"]!.map((x) => TeacherSyllabusItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherSyllabusItem {
  final int? id;
  final int? classId;
  final int? versionId;
  final Class? version;
  final Class? classData;

  const TeacherSyllabusItem({
    this.id,
    this.classId,
    this.versionId,
    this.version,
    this.classData,
  });

  factory TeacherSyllabusItem.fromJson(Map<String, dynamic> json) =>
      TeacherSyllabusItem(
        id: json["id"],
        classId: json["class_id"],
        versionId: json["version_id"],
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        classData: json["class"] == null ? null : Class.fromJson(json["class"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "version_id": versionId,
        "version": version?.toJson(),
        "class": classData?.toJson(),
      };
}

class Class {
  final int? id;
  final String? name;

  const Class({
    this.id,
    this.name,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
