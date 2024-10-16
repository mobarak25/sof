class TeacherLeaveDetails {
  final Data? data;

  const TeacherLeaveDetails({
    this.data,
  });

  factory TeacherLeaveDetails.fromJson(Map<String, dynamic> json) =>
      TeacherLeaveDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? comment;
  final int? leaveTypeId;
  final int? isEmergency;
  final int? applicationType;
  final String? applicationDate;
  final String? fromDate;
  final String? toDate;
  final dynamic approverId;
  final int? employeeId;
  final int? status;
  final String? attachment;
  final LeaveType? leaveType;
  final dynamic approvedBy;
  final Employee? employee;

  const Data({
    this.id,
    this.comment,
    this.leaveTypeId,
    this.isEmergency,
    this.applicationType,
    this.applicationDate,
    this.fromDate,
    this.toDate,
    this.approverId,
    this.employeeId,
    this.status,
    this.attachment,
    this.leaveType,
    this.approvedBy,
    this.employee,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        comment: json["comment"],
        leaveTypeId: json["leave_type_id"],
        isEmergency: json["is_emergency"],
        applicationType: json["application_type"],
        applicationDate: json["application_date"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        approverId: json["approver_id"],
        employeeId: json["employee_id"],
        status: json["status"],
        attachment: json["attachment"],
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
        "application_type": applicationType,
        "application_date": applicationDate,
        "from_date": fromDate,
        "to_date": toDate,
        "approver_id": approverId,
        "employee_id": employeeId,
        "status": status,
        "attachment": attachment,
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
