class LessonPlanDetails {
  final Data? data;

  const LessonPlanDetails({
    this.data,
  });

  factory LessonPlanDetails.fromJson(Map<String, dynamic> json) =>
      LessonPlanDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final String? content;
  final String? objectives;
  final int? status;
  final Subject? subject;
  final Class? version;
  final Class? dataClass;
  final List<Attachment>? attachments;
  final List<Resource>? resources;
  final Class? section;
  final Batch? batch;

  const Data({
    this.id,
    this.title,
    this.content,
    this.objectives,
    this.status,
    this.subject,
    this.version,
    this.dataClass,
    this.attachments,
    this.resources,
    this.section,
    this.batch,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        objectives: json["objectives"],
        status: json["status"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        dataClass: json["class"] == null ? null : Class.fromJson(json["class"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        resources: json["resources"] == null
            ? []
            : List<Resource>.from(
                json["resources"]!.map((x) => Resource.fromJson(x))),
        section:
            json["section"] == null ? null : Class.fromJson(json["section"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "objectives": objectives,
        "status": status,
        "subject": subject?.toJson(),
        "version": version?.toJson(),
        "class": dataClass?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "resources": resources == null
            ? []
            : List<dynamic>.from(resources!.map((x) => x.toJson())),
        "section": section?.toJson(),
        "batch": batch?.toJson(),
      };
}

class Attachment {
  final int? id;
  final int? lessonPlanId;
  final String? url;

  const Attachment({
    this.id,
    this.lessonPlanId,
    this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        lessonPlanId: json["lesson_plan_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_plan_id": lessonPlanId,
        "url": url,
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? sectionId;
  final Class? section;

  const Batch({
    this.id,
    this.name,
    this.sectionId,
    this.section,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
        sectionId: json["section_id"],
        section:
            json["section"] == null ? null : Class.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "section_id": sectionId,
        "section": section?.toJson(),
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

class Resource {
  final int? id;
  final int? lessonPlanId;
  final int? resourceId;
  final Resouce? resouce;

  const Resource({
    this.id,
    this.lessonPlanId,
    this.resourceId,
    this.resouce,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json["id"],
        lessonPlanId: json["lesson_plan_id"],
        resourceId: json["resource_id"],
        resouce:
            json["resouce"] == null ? null : Resouce.fromJson(json["resouce"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_plan_id": lessonPlanId,
        "resource_id": resourceId,
        "resouce": resouce?.toJson(),
      };
}

class Resouce {
  final int? id;
  final String? title;
  final String? content;
  final int? resourceType;
  final int? chapterId;
  final String? thumbnail;

  const Resouce({
    this.id,
    this.title,
    this.content,
    this.resourceType,
    this.chapterId,
    this.thumbnail,
  });

  factory Resouce.fromJson(Map<String, dynamic> json) => Resouce(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        resourceType: json["resource_type"],
        chapterId: json["chapter_id"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "resource_type": resourceType,
        "chapter_id": chapterId,
        "thumbnail": thumbnail,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? subjectGroupId;
  final Class? subjectGroup;

  const Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.subjectGroupId,
    this.subjectGroup,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
        subjectGroup: json["subject_group"] == null
            ? null
            : Class.fromJson(json["subject_group"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
        "subject_group": subjectGroup?.toJson(),
      };
}
