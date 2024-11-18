class QuizDetailsForTeacher {
  final Data? data;

  const QuizDetailsForTeacher({
    this.data,
  });

  factory QuizDetailsForTeacher.fromJson(Map<String, dynamic> json) =>
      QuizDetailsForTeacher(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final int? isCommon;
  final int? allowLateSubmission;
  final int? markEditable;
  final String? startDateTime;
  final String? endDateTime;
  final int? duration;
  final int? pass;
  final int? subjectId;
  final int? questionLevelId;
  final int? totalMark;
  final int? totalQuestion;
  final int? reviewPrevious;
  final int? greaseTime;
  final int? whitelisted;
  final int? allowRetake;
  final int? showResultEndOfQuiz;
  final int? showExplanationWithResult;
  final Subject? subject;
  final List<Question>? questions;
  final List<Ion>? sections;
  final List<int>? assignBatches;
  final List<int>? assignStudents;

  const Data({
    this.id,
    this.title,
    this.isCommon,
    this.allowLateSubmission,
    this.markEditable,
    this.startDateTime,
    this.endDateTime,
    this.duration,
    this.pass,
    this.subjectId,
    this.questionLevelId,
    this.totalMark,
    this.totalQuestion,
    this.reviewPrevious,
    this.greaseTime,
    this.whitelisted,
    this.allowRetake,
    this.showResultEndOfQuiz,
    this.showExplanationWithResult,
    this.subject,
    this.questions,
    this.sections,
    this.assignBatches,
    this.assignStudents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        isCommon: json["is_common"],
        allowLateSubmission: json["allow_late_submission"],
        markEditable: json["mark_editable"],
        startDateTime: json["start_date_time"],
        endDateTime: json["end_date_time"],
        duration: json["duration"],
        pass: json["pass"],
        subjectId: json["subject_id"],
        questionLevelId: json["question_level_id"],
        totalMark: json["total_mark"],
        totalQuestion: json["total_question"],
        reviewPrevious: json["review_previous"],
        greaseTime: json["grease_time"],
        whitelisted: json["whitelisted"],
        allowRetake: json["allow_retake"],
        showResultEndOfQuiz: json["show_result_end_of_quiz"],
        showExplanationWithResult: json["show_explanation_with_result"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        sections: json["sections"] == null
            ? []
            : List<Ion>.from(json["sections"]!.map((x) => Ion.fromJson(x))),
        assignBatches: json["assign_batches"] == null
            ? []
            : List<int>.from(json["assign_batches"]!.map((x) => x)),
        assignStudents: json["assign_students"] == null
            ? []
            : List<int>.from(json["assign_students"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_common": isCommon,
        "allow_late_submission": allowLateSubmission,
        "mark_editable": markEditable,
        "start_date_time": startDateTime,
        "end_date_time": endDateTime,
        "duration": duration,
        "pass": pass,
        "subject_id": subjectId,
        "question_level_id": questionLevelId,
        "total_mark": totalMark,
        "total_question": totalQuestion,
        "review_previous": reviewPrevious,
        "grease_time": greaseTime,
        "whitelisted": whitelisted,
        "allow_retake": allowRetake,
        "show_result_end_of_quiz": showResultEndOfQuiz,
        "show_explanation_with_result": showExplanationWithResult,
        "subject": subject?.toJson(),
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "sections": sections == null
            ? []
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
        "assign_batches": assignBatches == null
            ? []
            : List<dynamic>.from(assignBatches!.map((x) => x)),
        "assign_students": assignStudents == null
            ? []
            : List<dynamic>.from(assignStudents!.map((x) => x)),
      };
}

class Question {
  final int? id;
  final String? title;
  final int? mark;
  final Pivot? pivot;

  const Question({
    this.id,
    this.title,
    this.mark,
    this.pivot,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        title: json["title"],
        mark: json["mark"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "mark": mark,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  final int? quizId;
  final int? questionId;
  final int? mark;

  const Pivot({
    this.quizId,
    this.questionId,
    this.mark,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        quizId: json["quiz_id"],
        questionId: json["question_id"],
        mark: json["mark"],
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "question_id": questionId,
        "mark": mark,
      };
}

class Ion {
  final int? id;
  final String? name;

  Ion({
    this.id,
    this.name,
  });

  factory Ion.fromJson(Map<String, dynamic> json) => Ion(
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
  final int? classId;
  final int? versionId;
  final Class? subjectClass;
  final Ion? version;

  const Subject({
    this.id,
    this.name,
    this.classId,
    this.versionId,
    this.subjectClass,
    this.version,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        classId: json["class_id"],
        versionId: json["version_id"],
        subjectClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
        version: json["version"] == null ? null : Ion.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "class_id": classId,
        "version_id": versionId,
        "class": subjectClass?.toJson(),
        "version": version?.toJson(),
      };
}

class Class {
  final int? id;
  final String? name;
  final dynamic displayName;
  final String? code;

  const Class({
    this.id,
    this.name,
    this.displayName,
    this.code,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        name: json["name"],
        displayName: json["display_name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "display_name": displayName,
        "code": code,
      };
}
