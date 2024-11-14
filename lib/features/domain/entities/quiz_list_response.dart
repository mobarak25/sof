class QuizList {
  final int? currentPage;
  final List<QuizItem>? data;
  final int? lastPage;
  final int? total;

  const QuizList({
    this.currentPage,
    this.data,
    this.lastPage,
    this.total,
  });

  factory QuizList.fromJson(Map<String, dynamic> json) => QuizList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<QuizItem>.from(
                json["data"]!.map((x) => QuizItem.fromJson(x))),
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

class QuizItem {
  final int? id;
  final String? title;
  final String? startDateTime;
  final String? endDateTime;
  final int? totalMark;
  final int? totalQuestion;
  final int? subjectId;
  final Subject? subject;

  const QuizItem({
    this.id,
    this.title,
    this.startDateTime,
    this.endDateTime,
    this.totalMark,
    this.totalQuestion,
    this.subjectId,
    this.subject,
  });

  factory QuizItem.fromJson(Map<String, dynamic> json) => QuizItem(
        id: json["id"],
        title: json["title"],
        startDateTime: json["start_date_time"],
        endDateTime: json["end_date_time"],
        totalMark: json["total_mark"],
        totalQuestion: json["total_question"],
        subjectId: json["subject_id"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "start_date_time": startDateTime,
        "end_date_time": endDateTime,
        "total_mark": totalMark,
        "total_question": totalQuestion,
        "subject_id": subjectId,
        "subject": subject?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;
  final int? classId;
  final int? versionId;
  final Class? subjectClass;
  final Class? version;

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
            json["version"] == null ? null : Class.fromJson(json["version"]),
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
