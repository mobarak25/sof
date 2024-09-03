class GetBacthAsSections {
  final Data? data;

  const GetBacthAsSections({
    this.data,
  });

  factory GetBacthAsSections.fromJson(Map<String, dynamic> json) =>
      GetBacthAsSections(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final Versions? versions;

  const Data({
    this.versions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        versions: json["versions"] == null
            ? null
            : Versions.fromJson(json["versions"]),
      );

  Map<String, dynamic> toJson() => {
        "versions": versions?.toJson(),
      };
}

class Versions {
  final The1? the1;

  Versions({
    this.the1,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        the1: json["1"] == null ? null : The1.fromJson(json["1"]),
      );

  Map<String, dynamic> toJson() => {
        "1": the1?.toJson(),
      };
}

class The1 {
  final int? versionId;
  final String? versionName;
  final Classes? classes;

  The1({
    this.versionId,
    this.versionName,
    this.classes,
  });

  factory The1.fromJson(Map<String, dynamic> json) => The1(
        versionId: json["version_id"],
        versionName: json["version_name"],
        classes:
            json["classes"] == null ? null : Classes.fromJson(json["classes"]),
      );

  Map<String, dynamic> toJson() => {
        "version_id": versionId,
        "version_name": versionName,
        "classes": classes?.toJson(),
      };
}

class Classes {
  final The31? the31;

  Classes({
    this.the31,
  });

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        the31: json["31"] == null ? null : The31.fromJson(json["31"]),
      );

  Map<String, dynamic> toJson() => {
        "31": the31?.toJson(),
      };
}

class The31 {
  final int? classId;
  final String? className;
  final Map<String, Subject>? subjects;

  The31({
    this.classId,
    this.className,
    this.subjects,
  });

  factory The31.fromJson(Map<String, dynamic> json) => The31(
        classId: json["class_id"],
        className: json["class_name"],
        subjects: Map.from(json["subjects"]!)
            .map((k, v) => MapEntry<String, Subject>(k, Subject.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "class_id": classId,
        "class_name": className,
        "subjects": Map.from(subjects!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Subject {
  final int? subjectId;
  final String? subjectName;
  final Map<String, Section>? sections;

  Subject({
    this.subjectId,
    this.subjectName,
    this.sections,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        sections: Map.from(json["sections"]!)
            .map((k, v) => MapEntry<String, Section>(k, Section.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "subject_name": subjectName,
        "sections": Map.from(sections!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Section {
  final int? batchId;
  final SectionName? sectionName;

  Section({
    this.batchId,
    this.sectionName,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        batchId: json["batch_id"],
        sectionName: sectionNameValues.map[json["section_name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "batch_id": batchId,
        "section_name": sectionNameValues.reverse[sectionName],
      };
}

enum SectionName { A, B }

final sectionNameValues = EnumValues({"A": SectionName.A, "B": SectionName.B});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
