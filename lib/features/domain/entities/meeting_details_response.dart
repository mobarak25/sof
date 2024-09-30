class MeetingDetails {
  final Data? data;

  const MeetingDetails({
    this.data,
  });

  factory MeetingDetails.fromJson(Map<String, dynamic> json) => MeetingDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? userId;
  final int? employeeId;
  final String? title;
  final String? description;
  final int? meetingType;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? meetingLink;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final Batch? batch;
  final List<Agenda>? agenda;
  // final List<MeetingStudent>? meetingStudents;
  final List<int>? meetingStudents;
  final List<MeetingBatch>? meetingBatches;
  final Employee? employee;

  Data({
    this.id,
    this.userId,
    this.employeeId,
    this.title,
    this.description,
    this.meetingType,
    this.date,
    this.startTime,
    this.endTime,
    this.meetingLink,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.batch,
    this.agenda,
    this.meetingStudents,
    this.meetingBatches,
    this.employee,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        title: json["title"],
        description: json["description"],
        meetingType: json["meeting_type"],
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        meetingLink: json["meeting_link"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
        agenda: json["agenda"] == null
            ? []
            : List<Agenda>.from(json["agenda"]!.map((x) => Agenda.fromJson(x))),
        meetingStudents: json["meeting_students"] == null
            ? []
            : List<int>.from(json["meeting_students"]!.map((x) => x)),
        meetingBatches: json["meeting_batches"] == null
            ? []
            : List<MeetingBatch>.from(
                json["meeting_batches"]!.map((x) => MeetingBatch.fromJson(x))),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "title": title,
        "description": description,
        "meeting_type": meetingType,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "meeting_link": meetingLink,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "batch": batch?.toJson(),
        "agenda": agenda == null
            ? []
            : List<dynamic>.from(agenda!.map((x) => x.toJson())),
        "meeting_students": meetingStudents == null
            ? []
            : List<dynamic>.from(meetingStudents!.map((x) => x)),
        "meeting_batches": meetingBatches == null
            ? []
            : List<dynamic>.from(meetingBatches!.map((x) => x.toJson())),
        "employee": employee?.toJson(),
      };
}

class Agenda {
  final int? id;
  final int? meetingId;
  final String? title;

  Agenda({
    this.id,
    this.meetingId,
    this.title,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json["id"],
        meetingId: json["meeting_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meeting_id": meetingId,
        "title": title,
      };
}

class Batch {
  final int? id;
  final int? versionId;
  final int? classId;

  Batch({
    this.id,
    this.versionId,
    this.classId,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        versionId: json["version_id"],
        classId: json["class_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version_id": versionId,
        "class_id": classId,
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

class MeetingBatch {
  final int? id;
  final int? meetingId;
  final int? batchId;

  MeetingBatch({
    this.id,
    this.meetingId,
    this.batchId,
  });

  factory MeetingBatch.fromJson(Map<String, dynamic> json) => MeetingBatch(
        id: json["id"],
        meetingId: json["meeting_id"],
        batchId: json["batch_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meeting_id": meetingId,
        "batch_id": batchId,
      };
}

class MeetingStudent {
  final int? id;
  final int? meetingId;
  final int? studentId;

  MeetingStudent({
    this.id,
    this.meetingId,
    this.studentId,
  });

  factory MeetingStudent.fromJson(Map<String, dynamic> json) => MeetingStudent(
        id: json["id"],
        meetingId: json["meeting_id"],
        studentId: json["student_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meeting_id": meetingId,
        "student_id": studentId,
      };
}
