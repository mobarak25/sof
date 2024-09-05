class GetBacthAsSections {
  final List<DataItem>? data;

  const GetBacthAsSections({
    this.data,
  });

  factory GetBacthAsSections.fromJson(Map<String, dynamic> json) =>
      GetBacthAsSections(
        data: json["data"] == null
            ? []
            : List<DataItem>.from(
                json["data"]!.map((x) => DataItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataItem {
  final int? versionId;
  final String? versionName;
  final List<Class>? classes;

  const DataItem({
    this.versionId,
    this.versionName,
    this.classes,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        versionId: json["version_id"],
        versionName: json["version_name"],
        classes: json["classes"] == null
            ? []
            : List<Class>.from(json["classes"]!.map((x) => Class.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version_id": versionId,
        "version_name": versionName,
        "classes": classes == null
            ? []
            : List<dynamic>.from(classes!.map((x) => x.toJson())),
      };
}

class Class {
  final int? classId;
  final String? className;
  final List<Subject>? subjects;

  const Class({
    this.classId,
    this.className,
    this.subjects,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        classId: json["class_id"],
        className: json["class_name"],
        subjects: json["subjects"] == null
            ? []
            : List<Subject>.from(
                json["subjects"]!.map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
      };
}

class Subject {
  final int? subjectId;
  final String? subjectName;
  final List<Section>? sections;

  const Subject({
    this.subjectId,
    this.subjectName,
    this.sections,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        sections: json["sections"] == null
            ? []
            : List<Section>.from(
                json["sections"]!.map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "subject_name": subjectName,
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}

class Section {
  final int? batchId;
  final String? sectionName;

  const Section({
    this.batchId,
    this.sectionName,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        batchId: json["batch_id"],
        sectionName: json["section_name"],
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "section_name": sectionName,
      };
}
