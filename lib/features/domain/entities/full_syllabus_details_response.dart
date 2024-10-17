class FullSyllabusDetails {
  final Data? data;

  const FullSyllabusDetails({
    this.data,
  });

  factory FullSyllabusDetails.fromJson(Map<String, dynamic> json) =>
      FullSyllabusDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? classId;
  final int? versionId;
  final Class? version;
  final Class? dataClass;
  final Attachment? attachment;

  const Data({
    this.id,
    this.classId,
    this.versionId,
    this.version,
    this.dataClass,
    this.attachment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        classId: json["class_id"],
        versionId: json["version_id"],
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        dataClass: json["class"] == null ? null : Class.fromJson(json["class"]),
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_id": classId,
        "version_id": versionId,
        "version": version?.toJson(),
        "class": dataClass?.toJson(),
        "attachment": attachment?.toJson(),
      };
}

class Attachment {
  final int? id;
  final int? syllabusFullsyllabusIs;
  final String? url;

  Attachment({
    this.id,
    this.syllabusFullsyllabusIs,
    this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        syllabusFullsyllabusIs: json["syllabus_fullsyllabus_is"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syllabus_fullsyllabus_is": syllabusFullsyllabusIs,
        "url": url,
      };
}

class Class {
  final int? id;
  final String? name;

  Class({
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
