class StudentLeaveList {
  final int? currentPage;
  final List<LeaveItem>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  const StudentLeaveList({
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

  factory StudentLeaveList.fromJson(Map<String, dynamic> json) =>
      StudentLeaveList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<LeaveItem>.from(
                json["data"]!.map((x) => LeaveItem.fromJson(x))),
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

class LeaveItem {
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

  const LeaveItem({
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
  });

  factory LeaveItem.fromJson(Map<String, dynamic> json) => LeaveItem(
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
      };
}

class LeaveType {
  final int? id;
  final String? name;

  const LeaveType({
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

  const Ent({
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

  const Teacher({
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
