class QuestionPaperDtls {
  final Data? data;

  const QuestionPaperDtls({
    this.data,
  });

  factory QuestionPaperDtls.fromJson(Map<String, dynamic> json) =>
      QuestionPaperDtls(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? name;
  final String? type;
  final String? datetime;
  final String? duration;
  final int? fullMark;
  final int? subjectId;
  final int? batchId;
  final int? totalQuestion;
  final Subject? subject;
  final Batch? batch;
  final List<QuestionPaperContent>? questionPaperContents;

  const Data({
    this.id,
    this.name,
    this.type,
    this.datetime,
    this.duration,
    this.fullMark,
    this.subjectId,
    this.batchId,
    this.totalQuestion,
    this.subject,
    this.batch,
    this.questionPaperContents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        datetime: json["datetime"],
        duration: json["duration"],
        fullMark: json["full_mark"],
        subjectId: json["subject_id"],
        batchId: json["batch_id"],
        totalQuestion: json["total_question"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        questionPaperContents: json["question_paper_contents"] == null
            ? []
            : List<QuestionPaperContent>.from(json["question_paper_contents"]!
                .map((x) => QuestionPaperContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "datetime": datetime,
        "duration": duration,
        "full_mark": fullMark,
        "subject_id": subjectId,
        "batch_id": batchId,
        "total_question": totalQuestion,
        "subject": subject?.toJson(),
        "batch": batch?.toJson(),
        "question_paper_contents": questionPaperContents == null
            ? []
            : List<dynamic>.from(questionPaperContents!.map((x) => x.toJson())),
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? versionId;
  final int? classId;

  Batch({
    this.id,
    this.name,
    this.versionId,
    this.classId,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
        versionId: json["version_id"],
        classId: json["class_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "version_id": versionId,
        "class_id": classId,
      };
}

class QuestionPaperContent {
  final int? id;
  final int? questionPaperId;
  final int? questionId;
  final int? questionMark;
  final Questions? questions;

  QuestionPaperContent({
    this.id,
    this.questionPaperId,
    this.questionId,
    this.questionMark,
    this.questions,
  });

  factory QuestionPaperContent.fromJson(Map<String, dynamic> json) =>
      QuestionPaperContent(
        id: json["id"],
        questionPaperId: json["question_paper_id"],
        questionId: json["question_id"],
        questionMark: json["question_mark"],
        questions: json["questions"] == null
            ? null
            : Questions.fromJson(json["questions"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_paper_id": questionPaperId,
        "question_id": questionId,
        "question_mark": questionMark,
        "questions": questions?.toJson(),
      };
}

class Questions {
  final int? id;
  final String? title;
  final int? mark;
  final String? questionExplanation;
  final String? correctAnswer;
  final int? imgHas;
  final int? type;
  final List<dynamic>? questionOptions;
  final Attachment? attachment;

  Questions({
    this.id,
    this.title,
    this.mark,
    this.questionExplanation,
    this.correctAnswer,
    this.imgHas,
    this.type,
    this.questionOptions,
    this.attachment,
  });

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        id: json["id"],
        title: json["title"],
        mark: json["mark"],
        questionExplanation: json["question_explanation"],
        correctAnswer: json["correct_answer"],
        imgHas: json["img_has"],
        type: json["type"],
        questionOptions: json["question_options"] == null
            ? []
            : List<dynamic>.from(json["question_options"]!.map((x) => x)),
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "mark": mark,
        "question_explanation": questionExplanation,
        "correct_answer": correctAnswer,
        "img_has": imgHas,
        "type": type,
        "question_options": questionOptions == null
            ? []
            : List<dynamic>.from(questionOptions!.map((x) => x)),
        "attachment": attachment?.toJson(),
      };
}

class Attachment {
  final int? id;
  final String? file;
  final int? questionId;

  Attachment({
    this.id,
    this.file,
    this.questionId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        file: json["file"],
        questionId: json["question_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "question_id": questionId,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? code;
  final int? subjectGroupId;

  Subject({
    this.id,
    this.name,
    this.code,
    this.subjectGroupId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        subjectGroupId: json["subject_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "subject_group_id": subjectGroupId,
      };
}
