class Routine {
  final int? currentPage;
  final List<RoutineItem>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  const Routine({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Routine.fromJson(Map<String, dynamic> json) => Routine(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<RoutineItem>.from(
                json["data"]!.map((x) => RoutineItem.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class RoutineItem {
  final int? id;
  final int? weekdayId;
  final Subject? subject;
  final Batch? classRoom;
  final ClassTimings? classTimings;
  final Batch? batch;
  final Employee? employee;

  RoutineItem({
    this.id,
    this.weekdayId,
    this.subject,
    this.classRoom,
    this.classTimings,
    this.batch,
    this.employee,
  });

  factory RoutineItem.fromJson(Map<String, dynamic> json) => RoutineItem(
        id: json["id"],
        weekdayId: json["weekday_id"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        classRoom: json["class_room"] == null
            ? null
            : Batch.fromJson(json["class_room"]),
        classTimings: json["class_timings"] == null
            ? null
            : ClassTimings.fromJson(json["class_timings"]),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weekday_id": weekdayId,
        "subject": subject?.toJson(),
        "class_room": classRoom?.toJson(),
        "class_timings": classTimings?.toJson(),
        "batch": batch?.toJson(),
        "employee": employee?.toJson(),
      };
}

class Batch {
  final int? id;
  final String? name;

  Batch({
    this.id,
    this.name,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ClassTimings {
  final int? id;
  final String? name;
  final String? startTime;
  final String? endTime;
  final dynamic isBreak;

  ClassTimings({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.isBreak,
  });

  factory ClassTimings.fromJson(Map<String, dynamic> json) => ClassTimings(
        id: json["id"],
        name: json["name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        isBreak: json["is_break"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_time": startTime,
        "end_time": endTime,
        "is_break": isBreak,
      };
}

class Employee {
  final int? id;
  final String? fullName;

  Employee({
    this.id,
    this.fullName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
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

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
