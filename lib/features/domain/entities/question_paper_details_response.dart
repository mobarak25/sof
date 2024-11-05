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

  const Batch({
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

  const QuestionPaperContent({
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
  final List<QuestionOption>? questionOptions;
  final QuestionsAttachment? attachment;

  const Questions({
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
            : List<QuestionOption>.from(json["question_options"]!
                .map((x) => QuestionOption.fromJson(x))),
        attachment: json["attachment"] == null
            ? null
            : QuestionsAttachment.fromJson(json["attachment"]),
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
            : List<dynamic>.from(questionOptions!.map((x) => x.toJson())),
        "attachment": attachment?.toJson(),
      };
}

class QuestionsAttachment {
  final int? id;
  final String? file;
  final int? questionId;

  const QuestionsAttachment({
    this.id,
    this.file,
    this.questionId,
  });

  factory QuestionsAttachment.fromJson(Map<String, dynamic> json) =>
      QuestionsAttachment(
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

class QuestionOption {
  final int? id;
  final int? questionId;
  final String? options;
  final int? isCorrect;
  final int? imgHas;
  final QuestionOptionAttachment? attachment;

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
            : QuestionOptionAttachment.fromJson(json["attachment"]),
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

class QuestionOptionAttachment {
  final int? id;
  final String? file;
  final int? questionsOptionId;

  const QuestionOptionAttachment({
    this.id,
    this.file,
    this.questionsOptionId,
  });

  factory QuestionOptionAttachment.fromJson(Map<String, dynamic> json) =>
      QuestionOptionAttachment(
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
