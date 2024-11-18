class AnswerQuiz {
  final int quizId;
  final int isFinalSubmit;
  final List<AnswerElement> answers;

  AnswerQuiz({
    required this.quizId,
    required this.isFinalSubmit,
    required this.answers,
  });

  factory AnswerQuiz.fromJson(Map<String, dynamic> json) => AnswerQuiz(
        quizId: json["quiz_id"],
        isFinalSubmit: json["is_final_submit"],
        answers: List<AnswerElement>.from(
            json["answers"].map((x) => AnswerElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "is_final_submit": isFinalSubmit,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
      };
}

class AnswerElement {
  final int questionId;
  final int type;
  final dynamic answer;

  AnswerElement({
    required this.questionId,
    required this.type,
    required this.answer,
  });

  factory AnswerElement.fromJson(Map<String, dynamic> json) => AnswerElement(
        questionId: json["question_id"],
        type: json["type"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "type": type,
        "answer": answer,
      };
}
