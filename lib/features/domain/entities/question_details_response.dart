class QuestionDetails {
  final Data? data;

  const QuestionDetails({
    this.data,
  });

  factory QuestionDetails.fromJson(Map<String, dynamic> json) =>
      QuestionDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final int? mark;
  final int? subjectId;
  final int? questionLevelId;
  final int? type;
  final String? questionExplanation;
  final String? correctAnswer;
  final List<Option>? options;
  final String? questionThumbnail;
  final Subject? subject;
  final Level? level;

  const Data({
    this.id,
    this.title,
    this.mark,
    this.subjectId,
    this.questionLevelId,
    this.type,
    this.questionExplanation,
    this.correctAnswer,
    this.options,
    this.questionThumbnail,
    this.subject,
    this.level,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        mark: json["mark"],
        subjectId: json["subject_id"],
        questionLevelId: json["question_level_id"],
        type: json["type"],
        questionExplanation: json["question_explanation"],
        correctAnswer: json["correct_answer"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        questionThumbnail: json["question_thumbnail"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "mark": mark,
        "subject_id": subjectId,
        "question_level_id": questionLevelId,
        "type": type,
        "question_explanation": questionExplanation,
        "correct_answer": correctAnswer,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "question_thumbnail": questionThumbnail,
        "subject": subject?.toJson(),
        "level": level?.toJson(),
      };
}

class Level {
  final int? id;
  final String? levelValue;

  const Level({
    this.id,
    this.levelValue,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        levelValue: json["level_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level_value": levelValue,
      };
}

class Option {
  final int? id;
  final int? questionId;
  final String? options;
  final int? isCorrect;
  final int? imgHas;
  final String? thumbnails;

  const Option({
    this.id,
    this.questionId,
    this.options,
    this.isCorrect,
    this.imgHas,
    this.thumbnails,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        questionId: json["question_id"],
        options: json["options"],
        isCorrect: json["is_correct"],
        imgHas: json["img_has"],
        thumbnails: json["thumbnails"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "options": options,
        "is_correct": isCorrect,
        "img_has": imgHas,
        "thumbnails": thumbnails,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final String? imageUrl;
  final int? classId;
  final int? versionId;
  final Class? version;
  final Class? subjectClass;

  const Subject({
    this.id,
    this.name,
    this.code,
    this.imageUrl,
    this.classId,
    this.versionId,
    this.version,
    this.subjectClass,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        imageUrl: json["image_url"],
        classId: json["class_id"],
        versionId: json["version_id"],
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        subjectClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "image_url": imageUrl,
        "class_id": classId,
        "version_id": versionId,
        "version": version?.toJson(),
        "class": subjectClass?.toJson(),
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
