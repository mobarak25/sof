class StudentProfileResponse {
  final Data? data;

  const StudentProfileResponse({
    this.data,
  });

  factory StudentProfileResponse.fromJson(Map<String, dynamic> json) =>
      StudentProfileResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? fullname;
  final String? admissionNumber;
  final String? dateOfBirth;
  final String? mobile;
  final String? imageUrl;
  final String? email;
  final int? gender;
  final String? bloodGroup;
  final String? religion;
  final String? classRollNo;
  final String? presentAddress;
  final String? permanentAddress;
  final int? batchId;
  final String? batchName;
  final String? versionName;
  final String? sectionName;
  final String? shiftName;
  final String? className;
  final String? schoolName;
  final List<Guardian>? guardians;

  Data({
    this.id,
    this.fullname,
    this.admissionNumber,
    this.dateOfBirth,
    this.mobile,
    this.imageUrl,
    this.email,
    this.gender,
    this.bloodGroup,
    this.religion,
    this.classRollNo,
    this.presentAddress,
    this.permanentAddress,
    this.batchId,
    this.batchName,
    this.versionName,
    this.sectionName,
    this.shiftName,
    this.className,
    this.schoolName,
    this.guardians,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullname: json["fullname"],
        admissionNumber: json["admission_number"],
        dateOfBirth: json["date_of_birth"],
        mobile: json["mobile"],
        imageUrl: json["image_url"],
        email: json["email"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        religion: json["religion"],
        classRollNo: json["class_roll_no"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        batchId: json["batch_id"],
        batchName: json["batch_name"],
        versionName: json["version_name"],
        sectionName: json["section_name"],
        shiftName: json["shift_name"],
        className: json["class_name"],
        schoolName: json["school_name"],
        guardians: json["guardians"] == null
            ? []
            : List<Guardian>.from(
                json["guardians"]!.map((x) => Guardian.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "admission_number": admissionNumber,
        "date_of_birth": dateOfBirth,
        "mobile": mobile,
        "image_url": imageUrl,
        "email": email,
        "gender": gender,
        "blood_group": bloodGroup,
        "religion": religion,
        "class_roll_no": classRollNo,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "batch_id": batchId,
        "batch_name": batchName,
        "version_name": versionName,
        "section_name": sectionName,
        "shift_name": shiftName,
        "class_name": className,
        "school_name": schoolName,
        "guardians": guardians == null
            ? []
            : List<dynamic>.from(guardians!.map((x) => x.toJson())),
      };
}

class Guardian {
  final int? id;
  final String? fullname;
  final String? mobile;
  final String? email;
  final String? presentAddress;
  final String? permanentAddress;
  final int? gender;
  final String? bloodGroup;
  final String? religion;
  final int? relation;

  Guardian({
    this.id,
    this.fullname,
    this.mobile,
    this.email,
    this.presentAddress,
    this.permanentAddress,
    this.gender,
    this.bloodGroup,
    this.religion,
    this.relation,
  });

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
        id: json["id"],
        fullname: json["fullname"],
        mobile: json["mobile"],
        email: json["email"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        religion: json["religion"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "mobile": mobile,
        "email": email,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "gender": gender,
        "blood_group": bloodGroup,
        "religion": religion,
        "relation": relation,
      };
}
