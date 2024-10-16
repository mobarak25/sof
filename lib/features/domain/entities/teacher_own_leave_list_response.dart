class TeacherOwnLeaveList {
  final int? currentPage;
  final List<OwnLeaveItem>? data;
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

  const TeacherOwnLeaveList({
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

  factory TeacherOwnLeaveList.fromJson(Map<String, dynamic> json) =>
      TeacherOwnLeaveList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<OwnLeaveItem>.from(
                json["data"]!.map((x) => OwnLeaveItem.fromJson(x))),
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

class OwnLeaveItem {
  final int? id;
  final String? comment;
  final int? leaveTypeId;
  final int? isEmergency;
  final String? applicationDate;
  final String? fromDate;
  final String? toDate;
  final dynamic approverId;
  final int? employeeId;
  final int? status;
  final LeaveType? leaveType;
  final dynamic approvedBy;
  final Employee? employee;

  const OwnLeaveItem({
    this.id,
    this.comment,
    this.leaveTypeId,
    this.isEmergency,
    this.applicationDate,
    this.fromDate,
    this.toDate,
    this.approverId,
    this.employeeId,
    this.status,
    this.leaveType,
    this.approvedBy,
    this.employee,
  });

  factory OwnLeaveItem.fromJson(Map<String, dynamic> json) => OwnLeaveItem(
        id: json["id"],
        comment: json["comment"],
        leaveTypeId: json["leave_type_id"],
        isEmergency: json["is_emergency"],
        applicationDate: json["application_date"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        approverId: json["approver_id"],
        employeeId: json["employee_id"],
        status: json["status"],
        leaveType: json["leave_type"] == null
            ? null
            : LeaveType.fromJson(json["leave_type"]),
        approvedBy: json["approved_by"],
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "leave_type_id": leaveTypeId,
        "is_emergency": isEmergency,
        "application_date": applicationDate,
        "from_date": fromDate,
        "to_date": toDate,
        "approver_id": approverId,
        "employee_id": employeeId,
        "status": status,
        "leave_type": leaveType?.toJson(),
        "approved_by": approvedBy,
        "employee": employee?.toJson(),
      };
}

class Employee {
  final int? id;
  final String? fullName;
  final String? shortCode;

  const Employee({
    this.id,
    this.fullName,
    this.shortCode,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        fullName: json["full_name"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "short_code": shortCode,
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
