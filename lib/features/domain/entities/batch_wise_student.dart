class BatchWiseStudent {
  final List<BatchWiseStudentItem>? data;

  const BatchWiseStudent({
    this.data,
  });

  factory BatchWiseStudent.fromJson(Map<String, dynamic> json) =>
      BatchWiseStudent(
        data: json["data"] == null
            ? []
            : List<BatchWiseStudentItem>.from(
                json["data"]!.map((x) => BatchWiseStudentItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BatchWiseStudentItem {
  final int? id;
  final String? name;
  final String? email;
  final dynamic phone;
  final int? gender;
  final String? rollNo;
  final String? admissionNumber;

  BatchWiseStudentItem({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.rollNo,
    this.admissionNumber,
  });

  factory BatchWiseStudentItem.fromJson(Map<String, dynamic> json) =>
      BatchWiseStudentItem(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        rollNo: json["roll_no"],
        admissionNumber: json["admission_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "roll_no": rollNo,
        "admission_number": admissionNumber,
      };
}
