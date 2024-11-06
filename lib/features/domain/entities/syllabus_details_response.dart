class SyllabusDetails {
  final Data? data;

  const SyllabusDetails({
    this.data,
  });

  factory SyllabusDetails.fromJson(Map<String, dynamic> json) =>
      SyllabusDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final dynamic content;
  final String? date;
  final int? versionId;
  final int? classId;
  final int? sectionId;
  final int? subjectId;
  final String? type;
  final int? status;
  final int? mark;
  final int? authorId;
  final Subject? subject;
  final Batch? batch;
  final dynamic dataClass;
  final List<Attachment>? attachments;

  const Data({
    this.id,
    this.title,
    this.content,
    this.date,
    this.versionId,
    this.classId,
    this.sectionId,
    this.subjectId,
    this.type,
    this.status,
    this.mark,
    this.authorId,
    this.subject,
    this.batch,
    this.dataClass,
    this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        date: json["date"],
        versionId: json["version_id"],
        classId: json["class_id"],
        sectionId: json["section_id"],
        subjectId: json["subject_id"],
        type: json["type"],
        status: json["status"],
        mark: json["mark"],
        authorId: json["author_id"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        dataClass: json["class"],
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "date": date,
        "version_id": versionId,
        "class_id": classId,
        "section_id": sectionId,
        "subject_id": subjectId,
        "type": type,
        "status": status,
        "mark": mark,
        "author_id": authorId,
        "subject": subject?.toJson(),
        "batch": batch?.toJson(),
        "class": dataClass,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
      };
}

class Attachment {
  final int? id;
  final int? syllabusId;
  final String? url;
  final String? type;

  Attachment({
    this.id,
    this.syllabusId,
    this.url,
    this.type,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        syllabusId: json["syllabus_id"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "syllabus_id": syllabusId,
        "url": url,
        "type": type,
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? sectionId;
  final Section? section;

  Batch({
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
            json["section"] == null ? null : Section.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "section_id": sectionId,
        "section": section?.toJson(),
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
  final String? imageUrl;
  final int? subjectGroupId;

  Subject({
    this.id,
    this.name,
    this.imageUrl,
    this.subjectGroupId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        subjectGroupId: json["subject_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "subject_group_id": subjectGroupId,
      };
}
