class StudentLeaveLDetails {
  final Data? data;

  const StudentLeaveLDetails({
    this.data,
  });

  factory StudentLeaveLDetails.fromJson(Map<String, dynamic> json) =>
      StudentLeaveLDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final String? reason;
  final int? leaveTypeId;
  final int? studentId;
  final int? teacherId;
  final int? parentId;
  final int? batchId;
  final int? noOfDay;
  final String? startDate;
  final String? endDate;
  final int? status;
  final int? isHalfDay;
  final Ent? student;
  final Ent? parent;
  final LeaveType? leaveType;
  final Teacher? teacher;
  final List<String>? attachments;
  final Batch? batch;

  Data({
    this.id,
    this.title,
    this.reason,
    this.leaveTypeId,
    this.studentId,
    this.teacherId,
    this.parentId,
    this.batchId,
    this.noOfDay,
    this.startDate,
    this.endDate,
    this.status,
    this.isHalfDay,
    this.student,
    this.parent,
    this.leaveType,
    this.teacher,
    this.attachments,
    this.batch,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        reason: json["reason"],
        leaveTypeId: json["leave_type_id"],
        studentId: json["student_id"],
        teacherId: json["teacher_id"],
        parentId: json["parent_id"],
        batchId: json["batch_id"],
        noOfDay: json["no_of_day"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        status: json["status"],
        isHalfDay: json["is_half_day"],
        student: json["student"] == null ? null : Ent.fromJson(json["student"]),
        parent: json["parent"] == null ? null : Ent.fromJson(json["parent"]),
        leaveType: json["leave_type"] == null
            ? null
            : LeaveType.fromJson(json["leave_type"]),
        teacher:
            json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]),
        attachments: json["attachments"] == null
            ? []
            : List<String>.from(json["attachments"]!.map((x) => x)),
        batch: json["batch"] == null ? null : Batch.fromJson(json["batch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "reason": reason,
        "leave_type_id": leaveTypeId,
        "student_id": studentId,
        "teacher_id": teacherId,
        "parent_id": parentId,
        "batch_id": batchId,
        "no_of_day": noOfDay,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
        "is_half_day": isHalfDay,
        "student": student?.toJson(),
        "parent": parent?.toJson(),
        "leave_type": leaveType?.toJson(),
        "teacher": teacher?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "batch": batch?.toJson(),
      };
}

class Batch {
  final int? id;
  final String? name;
  final int? sectionId;
  final int? classId;
  final int? versionId;
  final LeaveType? version;
  final LeaveType? batchClass;
  final LeaveType? section;

  Batch({
    this.id,
    this.name,
    this.sectionId,
    this.classId,
    this.versionId,
    this.version,
    this.batchClass,
    this.section,
  });

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        id: json["id"],
        name: json["name"],
        sectionId: json["section_id"],
        classId: json["class_id"],
        versionId: json["version_id"],
        version: json["version"] == null
            ? null
            : LeaveType.fromJson(json["version"]),
        batchClass:
            json["class"] == null ? null : LeaveType.fromJson(json["class"]),
        section: json["section"] == null
            ? null
            : LeaveType.fromJson(json["section"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "section_id": sectionId,
        "class_id": classId,
        "version_id": versionId,
        "version": version?.toJson(),
        "class": batchClass?.toJson(),
        "section": section?.toJson(),
      };
}

class LeaveType {
  final int? id;
  final String? name;

  LeaveType({
    this.id,
    this.name,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) => LeaveType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Ent {
  final int? id;
  final String? firstName;
  final dynamic middleName;
  final dynamic lastName;
  final String? fullName;

  Ent({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.fullName,
  });

  factory Ent.fromJson(Map<String, dynamic> json) => Ent(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "full_name": fullName,
      };
}

class Teacher {
  final int? id;
  final String? fullName;

  Teacher({
    this.id,
    this.fullName,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
      };
}
