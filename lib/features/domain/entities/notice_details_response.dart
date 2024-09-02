class NoticeDetailsResponse {
  final Data? data;

  const NoticeDetailsResponse({
    this.data,
  });

  factory NoticeDetailsResponse.fromJson(Map<String, dynamic> json) =>
      NoticeDetailsResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final String? description;
  final int? isCommon;
  final int? type;
  final int? status;
  final dynamic iconUrl;
  final List<Attachment>? attachments;
  final int? isCommentable;
  final int? authorId;
  final String? createdAt;
  final String? authorName;
  final List<Employee>? employees;
  final Map<String, Employee>? students;
  final List<int>? departmentIdArray;
  final List<int>? batchIdArray;
  final List<int>? studentIdArray;
  final List<int>? employeeIdArray;

  const Data({
    this.id,
    this.title,
    this.description,
    this.isCommon,
    this.type,
    this.status,
    this.iconUrl,
    this.attachments,
    this.isCommentable,
    this.authorId,
    this.createdAt,
    this.authorName,
    this.employees,
    this.students,
    this.departmentIdArray,
    this.batchIdArray,
    this.studentIdArray,
    this.employeeIdArray,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isCommon: json["is_common"],
        type: json["type"],
        status: json["status"],
        iconUrl: json["icon_url"],
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        isCommentable: json["is_commentable"],
        authorId: json["author_id"],
        createdAt: json["created_at"],
        authorName: json["author_name"],
        employees: json["employees"] == null
            ? []
            : List<Employee>.from(
                json["employees"]!.map((x) => Employee.fromJson(x))),
        students: Map.from(json["students"]!)
            .map((k, v) => MapEntry<String, Employee>(k, Employee.fromJson(v))),
        departmentIdArray: json["department_id_array"] == null
            ? []
            : List<int>.from(json["department_id_array"]!.map((x) => x)),
        batchIdArray: json["batch_id_array"] == null
            ? []
            : List<int>.from(json["batch_id_array"]!.map((x) => x)),
        studentIdArray: json["student_id_array"] == null
            ? []
            : List<int>.from(json["student_id_array"]!.map((x) => x)),
        employeeIdArray: json["employee_id_array"] == null
            ? []
            : List<int>.from(json["employee_id_array"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_common": isCommon,
        "type": type,
        "status": status,
        "icon_url": iconUrl,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "is_commentable": isCommentable,
        "author_id": authorId,
        "created_at": createdAt,
        "author_name": authorName,
        "employees": employees == null
            ? []
            : List<dynamic>.from(employees!.map((x) => x.toJson())),
        "students": Map.from(students!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "department_id_array": departmentIdArray == null
            ? []
            : List<dynamic>.from(departmentIdArray!.map((x) => x)),
        "batch_id_array": batchIdArray == null
            ? []
            : List<dynamic>.from(batchIdArray!.map((x) => x)),
        "student_id_array": studentIdArray == null
            ? []
            : List<dynamic>.from(studentIdArray!.map((x) => x)),
        "employee_id_array": employeeIdArray == null
            ? []
            : List<dynamic>.from(employeeIdArray!.map((x) => x)),
      };
}

class Attachment {
  final int? id;
  final int? noticeId;
  final String? file;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Attachment({
    this.id,
    this.noticeId,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        noticeId: json["notice_id"],
        file: json["file"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "notice_id": noticeId,
        "file": file,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class Employee {
  final String? fullName;
  final String? image;

  Employee({
    this.fullName,
    this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        fullName: json["full_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "image": image,
      };
}
