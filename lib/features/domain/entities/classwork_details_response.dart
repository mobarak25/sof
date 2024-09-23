class ClassworkDetails {
  final Data? data;

  const ClassworkDetails({
    this.data,
  });

  factory ClassworkDetails.fromJson(Map<String, dynamic> json) =>
      ClassworkDetails(
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
  final String? publishedAt;
  final int? status;
  final Subject? subject;
  final List<Attachment>? attachments;
  final List<Section>? sections;
  final List<int>? assignBatches;
  final List<int>? assignStudents;

  Data({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.status,
    this.subject,
    this.attachments,
    this.sections,
    this.assignBatches,
    this.assignStudents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        publishedAt: json["published_at"],
        status: json["status"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
        assignBatches: json["assign_batches"] == null
            ? []
            : List<int>.from(json["assign_batches"]!.map((x) => x)),
        assignStudents: json["assign_students"] == null
            ? []
            : List<int>.from(json["assign_students"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "published_at": publishedAt,
        "status": status,
        "subject": subject?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "assign_batches": assignBatches == null
            ? []
            : List<dynamic>.from(assignBatches!.map((x) => x)),
        "assign_students": assignStudents == null
            ? []
            : List<dynamic>.from(assignStudents!.map((x) => x)),
      };
}

class Attachment {
  final int? id;
  final int? classWorkId;
  final String? url;
  final String? type;

  Attachment({
    this.id,
    this.classWorkId,
    this.url,
    this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        classWorkId: json["class_work_id"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "class_work_id": classWorkId,
        "url": url,
        "type": type,
      };
}

class Section {
  final int? id;
  final String? name;

  Section({
    this.id,
    this.name,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? subjectGroupId;
  final int? classId;
  final int? versionId;

  Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.subjectGroupId,
    this.classId,
    this.versionId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
        classId: json["class_id"],
        versionId: json["version_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
        "class_id": classId,
        "version_id": versionId,
      };
}
