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
  final dynamic correctAnswer;
  final Subject? subject;
  final Level? level;
  final List<QuestionOption>? questionOptions;

  const Data({
    this.id,
    this.title,
    this.mark,
    this.subjectId,
    this.questionLevelId,
    this.type,
    this.questionExplanation,
    this.correctAnswer,
    this.subject,
    this.level,
    this.questionOptions,
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
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        level: json["level"] == null ? null : Level.fromJson(json["level"]),
        questionOptions: json["question_options"] == null
            ? []
            : List<QuestionOption>.from(json["question_options"]!
                .map((x) => QuestionOption.fromJson(x))),
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
        "subject": subject?.toJson(),
        "level": level?.toJson(),
        "question_options": questionOptions == null
            ? []
            : List<dynamic>.from(questionOptions!.map((x) => x.toJson())),
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

class QuestionOption {
  final int? id;
  final int? questionId;
  final dynamic options;
  final int? isCorrect;
  final int? imgHas;
  final Attachment? attachment;

  const QuestionOption({
    this.id,
    this.questionId,
    this.options,
    this.isCorrect,
    this.imgHas,
    this.attachment,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
        id: json["id"],
        questionId: json["question_id"],
        options: json["options"],
        isCorrect: json["is_correct"],
        imgHas: json["img_has"],
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "options": options,
        "is_correct": isCorrect,
        "img_has": imgHas,
        "attachment": attachment?.toJson(),
      };
}

class Attachment {
  final int? id;
  final String? file;
  final int? questionsOptionId;

  const Attachment({
    this.id,
    this.file,
    this.questionsOptionId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        file: json["file"],
        questionsOptionId: json["questions_option_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "questions_option_id": questionsOptionId,
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
