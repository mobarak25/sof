class ExamList {
  final int? currentPage;
  final List<ExamItem>? data;
  final int? lastPage;
  final int? total;

  const ExamList({
    this.currentPage,
    this.data,
    this.lastPage,
    this.total,
  });

  factory ExamList.fromJson(Map<String, dynamic> json) => ExamList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ExamItem>.from(
                json["data"]!.map((x) => ExamItem.fromJson(x))),
        lastPage: json["last_page"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "last_page": lastPage,
        "total": total,
      };
}

class ExamItem {
  final int? id;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? maxMark;
  final int? convertMark;
  final int? passMark;
  final int? subjectId;
  final int? batchId;
  final int? examGroupId;
  final int? isPublished;
  final int? termId;
  final int? totalAttended;
  final int? totalAbsent;
  final Subject? subject;
  final Batch? batch;
  final ExamGroup? examGroup;

  const ExamItem({
    this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.maxMark,
    this.convertMark,
    this.passMark,
    this.subjectId,
    this.batchId,
    this.examGroupId,
    this.isPublished,
    this.termId,
    this.totalAttended,
    this.totalAbsent,
    this.subject,
    this.batch,
    this.examGroup,
  });

  factory ExamItem.fromJson(Map<String, dynamic> json) => ExamItem(
        id: json["id"],
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        maxMark: json["max_mark"],
        convertMark: json["convert_mark"],
        passMark: json["pass_mark"],
        subjectId: json["subject_id"],
        batchId: json["batch_id"],
        examGroupId: json["exam_group_id"],
        isPublished: json["is_published"],
        termId: json["term_id"],
        totalAttended: json["total_attended"],
        totalAbsent: json["total_absent"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        examGroup: json["exam_group"] == null
            ? null
            : ExamGroup.fromJson(json["exam_group"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "max_mark": maxMark,
        "convert_mark": convertMark,
        "pass_mark": passMark,
        "subject_id": subjectId,
        "batch_id": batchId,
        "exam_group_id": examGroupId,
        "is_published": isPublished,
        "term_id": termId,
        "total_attended": totalAttended,
        "total_absent": totalAbsent,
        "subject": subject?.toJson(),
        "batch": batch?.toJson(),
        "exam_group": examGroup?.toJson(),
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? classId;
  final int? versionId;
  final int? sectionId;
  final Section? section;

  Batch({
    this.id,
    this.name,
    this.classId,
    this.versionId,
    this.sectionId,
    this.section,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
        classId: json["class_id"],
        versionId: json["version_id"],
        sectionId: json["section_id"],
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "class_id": classId,
        "version_id": versionId,
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

class ExamGroup {
  final int? id;
  final String? name;
  final int? classId;
  final int? versionId;
  final int? examCategoryId;
  final Section? examCategory;

  ExamGroup({
    this.id,
    this.name,
    this.classId,
    this.versionId,
    this.examCategoryId,
    this.examCategory,
  });

  factory ExamGroup.fromJson(Map<String, dynamic> json) => ExamGroup(
        id: json["id"],
        name: json["name"],
        classId: json["class_id"],
        versionId: json["version_id"],
        examCategoryId: json["exam_category_id"],
        examCategory: json["exam_category"] == null
            ? null
            : Section.fromJson(json["exam_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "class_id": classId,
        "version_id": versionId,
        "exam_category_id": examCategoryId,
        "exam_category": examCategory?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;

  Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
      };
}
