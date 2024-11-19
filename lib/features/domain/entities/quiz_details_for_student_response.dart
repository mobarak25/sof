class QuizDetailsForStudent {
  final Data? data;

  const QuizDetailsForStudent({
    this.data,
  });

  factory QuizDetailsForStudent.fromJson(Map<String, dynamic> json) =>
      QuizDetailsForStudent(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final int? allowLateSubmission;
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
  final int? allowRetake;
  final int? showResultEndOfQuiz;
  final int? showExplanationWithResult;
  final StudentTime? studentTime;
  final int? totalCorrectAnswer;
  final List<Question>? questions;
  final Subject? subject;

  const Data({
    this.id,
    this.title,
    this.allowLateSubmission,
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
    this.allowRetake,
    this.showResultEndOfQuiz,
    this.showExplanationWithResult,
    this.studentTime,
    this.totalCorrectAnswer,
    this.questions,
    this.subject,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        allowLateSubmission: json["allow_late_submission"],
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
        allowRetake: json["allow_retake"],
        showResultEndOfQuiz: json["show_result_end_of_quiz"],
        showExplanationWithResult: json["show_explanation_with_result"],
        studentTime: json["student_time"] == null
            ? null
            : StudentTime.fromJson(json["student_time"]),
        totalCorrectAnswer: json["total_correct_answer"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "allow_late_submission": allowLateSubmission,
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
        "allow_retake": allowRetake,
        "show_result_end_of_quiz": showResultEndOfQuiz,
        "show_explanation_with_result": showExplanationWithResult,
        "student_time": studentTime?.toJson(),
        "total_correct_answer": totalCorrectAnswer,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
        "subject": subject?.toJson(),
      };
}

class Question {
  final int? id;
  final String? title;
  final int? mark;
  final int? type;
  final String? questionExplanation;
  final String? correctAnswer;
  final Answer? answer;
  final Pivot? pivot;
  final List<QuestionOption>? questionOptions;

  const Question({
    this.id,
    this.title,
    this.mark,
    this.type,
    this.questionExplanation,
    this.correctAnswer,
    this.answer,
    this.pivot,
    this.questionOptions,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        title: json["title"],
        mark: json["mark"],
        type: json["type"],
        questionExplanation: json["question_explanation"],
        correctAnswer: json["correct_answer"],
        answer: json["answer"] == null ? null : Answer.fromJson(json["answer"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        questionOptions: json["question_options"] == null
            ? []
            : List<QuestionOption>.from(json["question_options"]!
                .map((x) => QuestionOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "mark": mark,
        "type": type,
        "question_explanation": questionExplanation,
        "correct_answer": correctAnswer,
        "answer": answer?.toJson(),
        "pivot": pivot?.toJson(),
        "question_options": questionOptions == null
            ? []
            : List<dynamic>.from(questionOptions!.map((x) => x.toJson())),
      };
}

class Answer {
  final int? id;
  final int? questionId;
  final int? questionsOptionsId;
  final int? isCorrect;
  final dynamic attachment;
  final String? questionsAns;
  final dynamic givenMark;
  final dynamic markingExplaination;

  const Answer({
    this.id,
    this.questionId,
    this.questionsOptionsId,
    this.isCorrect,
    this.attachment,
    this.questionsAns,
    this.givenMark,
    this.markingExplaination,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        questionId: json["question_id"],
        questionsOptionsId: json["questions_options_id"],
        isCorrect: json["is_correct"],
        attachment: json["attachment"],
        questionsAns: json["questions_ans"],
        givenMark: json["given_mark"],
        markingExplaination: json["marking_explaination"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "questions_options_id": questionsOptionsId,
        "is_correct": isCorrect,
        "attachment": attachment,
        "questions_ans": questionsAns,
        "given_mark": givenMark,
        "marking_explaination": markingExplaination,
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

class QuestionOption {
  final int? id;
  final int? questionId;
  final String? options;
  final int? imgHas;
  final int? isCorrect;
  final Attachment? attachment;

  const QuestionOption({
    this.id,
    this.questionId,
    this.options,
    this.imgHas,
    this.isCorrect,
    this.attachment,
  });

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
        id: json["id"],
        questionId: json["question_id"],
        options: json["options"],
        imgHas: json["img_has"],
        isCorrect: json["is_correct"],
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "options": options,
        "img_has": imgHas,
        "is_correct": isCorrect,
        "attachment": attachment?.toJson(),
      };
}

class Attachment {
  final int? id;
  final int? questionsOptionId;
  final String? file;

  const Attachment({
    this.id,
    this.questionsOptionId,
    this.file,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        questionsOptionId: json["questions_option_id"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questions_option_id": questionsOptionId,
        "file": file,
      };
}

class StudentTime {
  final int? id;
  final int? quizId;
  final int? obtainedMark;
  final String? startTime;
  final String? endTime;
  final int? endStatus;
  final int? takenTime;

  const StudentTime({
    this.id,
    this.quizId,
    this.obtainedMark,
    this.startTime,
    this.endTime,
    this.endStatus,
    this.takenTime,
  });

  factory StudentTime.fromJson(Map<String, dynamic> json) => StudentTime(
        id: json["id"],
        quizId: json["quiz_id"],
        obtainedMark: json["obtained_mark"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        endStatus: json["end_status"],
        takenTime: json["taken_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "obtained_mark": obtainedMark,
        "start_time": startTime,
        "end_time": endTime,
        "end_status": endStatus,
        "taken_time": takenTime,
      };
}

class Subject {
  final int? id;
  final String? name;
  final int? classId;
  final int? versionId;
  final Class? subjectClass;
  final Version? version;

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
        version:
            json["version"] == null ? null : Version.fromJson(json["version"]),
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

class Version {
  final int? id;
  final String? name;

  const Version({
    this.id,
    this.name,
  });

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
