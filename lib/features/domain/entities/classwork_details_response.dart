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
  final int? versionId;
  final int? classId;
  final int? subjectId;
  final String? subject;
  final int? status;
  final int? subjectGroupId;
  final List<String>? attachment;
  final List<AssignedBatch>? assignedBatches;
  final List<AssignedBatch>? sections;
  final List<int>? assignStudents;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const Data({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.versionId,
    this.classId,
    this.subjectId,
    this.subject,
    this.status,
    this.subjectGroupId,
    this.attachment,
    this.assignedBatches,
    this.sections,
    this.assignStudents,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        publishedAt: json["published_at"],
        versionId: json["version_id"],
        classId: json["class_id"],
        subjectId: json["subject_id"],
        subject: json["subject"],
        status: json["status"],
        subjectGroupId: json["subject_group_id"],
        attachment: json["attachment"] == null
            ? []
            : List<String>.from(json["attachment"]!.map((x) => x)),
        assignedBatches: json["assigned_batches"] == null
            ? []
            : List<AssignedBatch>.from(json["assigned_batches"]!
                .map((x) => AssignedBatch.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<AssignedBatch>.from(
                json["sections"]!.map((x) => AssignedBatch.fromJson(x))),
        assignStudents: json["assign_students"] == null
            ? []
            : List<int>.from(json["assign_students"]!.map((x) => x)),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "published_at": publishedAt,
        "version_id": versionId,
        "class_id": classId,
        "subject_id": subjectId,
        "subject": subject,
        "status": status,
        "subject_group_id": subjectGroupId,
        "attachment": attachment == null
            ? []
            : List<dynamic>.from(attachment!.map((x) => x)),
        "assigned_batches": assignedBatches == null
            ? []
            : List<dynamic>.from(assignedBatches!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "assign_students": assignStudents == null
            ? []
            : List<dynamic>.from(assignStudents!.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class AssignedBatch {
  final int? id;
  final String? name;

  AssignedBatch({
    this.id,
    this.name,
  });

  factory AssignedBatch.fromJson(Map<String, dynamic> json) => AssignedBatch(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
