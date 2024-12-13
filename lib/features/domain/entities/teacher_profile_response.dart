class TeacherProfileResponse {
  final Data? data;

  const TeacherProfileResponse({
    this.data,
  });

  factory TeacherProfileResponse.fromJson(Map<String, dynamic> json) =>
      TeacherProfileResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? userId;
  final String? fullname;
  final String? employeeNumber;
  final String? categoryName;
  final String? shortCode;
  final dynamic gender;
  final dynamic maritalStatus;
  final String? dob;
  final dynamic signature;
  final dynamic birthCertificateNo;
  final String? nationalIdNo;
  final dynamic passportNo;
  final dynamic phone;
  final dynamic altPhone;
  final dynamic mobile;
  final String? smsNumber;
  final String? email;
  final dynamic altEmail;
  final dynamic presentAddress;
  final dynamic permanentAddress;
  final dynamic fatherName;
  final dynamic motherName;
  final dynamic spouseName;
  final dynamic etin;
  final dynamic bloodGroup;
  final dynamic emergencyContact;
  final String? image;
  final dynamic bioMedia;
  final dynamic bioMediaUrl;
  final dynamic bio;
  final int? childrenHas;
  final dynamic religion;
  final dynamic emergencyContactName;
  final dynamic emergencyContactRelation;
  final String? schoolName;
  final Employment? employment;
  final List<Exprience>? exprience;
  final String? tagline;
  final int? yearOfExperience;
  final dynamic classesPerWeek;
  final dynamic gradeName;
  final List<ProfessionalProfile>? professionalProfiles;

  const Data({
    this.id,
    this.userId,
    this.fullname,
    this.employeeNumber,
    this.categoryName,
    this.shortCode,
    this.gender,
    this.maritalStatus,
    this.dob,
    this.signature,
    this.birthCertificateNo,
    this.nationalIdNo,
    this.passportNo,
    this.phone,
    this.altPhone,
    this.mobile,
    this.smsNumber,
    this.email,
    this.altEmail,
    this.presentAddress,
    this.permanentAddress,
    this.fatherName,
    this.motherName,
    this.spouseName,
    this.etin,
    this.bloodGroup,
    this.emergencyContact,
    this.image,
    this.bioMedia,
    this.bioMediaUrl,
    this.bio,
    this.childrenHas,
    this.religion,
    this.emergencyContactName,
    this.emergencyContactRelation,
    this.schoolName,
    this.employment,
    this.exprience,
    this.tagline,
    this.yearOfExperience,
    this.classesPerWeek,
    this.gradeName,
    this.professionalProfiles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        fullname: json["fullname"],
        employeeNumber: json["employee_number"],
        categoryName: json["category_name"],
        shortCode: json["short_code"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        dob: json["dob"],
        signature: json["signature"],
        birthCertificateNo: json["birth_certificate_no"],
        nationalIdNo: json["national_id_no"],
        passportNo: json["passport_no"],
        phone: json["phone"],
        altPhone: json["alt_phone"],
        mobile: json["mobile"],
        smsNumber: json["sms_number"],
        email: json["email"],
        altEmail: json["alt_email"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        spouseName: json["spouse_name"],
        etin: json["etin"],
        bloodGroup: json["blood_group"],
        emergencyContact: json["emergency_contact"],
        image: json["image"],
        bioMedia: json["bio_media"],
        bioMediaUrl: json["bio_media_url"],
        bio: json["bio"],
        childrenHas: json["children_has"],
        religion: json["religion"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactRelation: json["emergency_contact_relation"],
        schoolName: json["school_name"],
        employment: json["employment"] == null
            ? null
            : Employment.fromJson(json["employment"]),
        exprience: json["exprience"] == null
            ? []
            : List<Exprience>.from(
                json["exprience"]!.map((x) => Exprience.fromJson(x))),
        tagline: json["tagline"],
        yearOfExperience: json["year_of_experience"],
        classesPerWeek: json["classes_per_week"],
        gradeName: json["grade_name"],
        professionalProfiles: json["professional_profiles"] == null
            ? []
            : List<ProfessionalProfile>.from(json["professional_profiles"]!
                .map((x) => ProfessionalProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "fullname": fullname,
        "employee_number": employeeNumber,
        "category_name": categoryName,
        "short_code": shortCode,
        "gender": gender,
        "marital_status": maritalStatus,
        "dob": dob,
        "signature": signature,
        "birth_certificate_no": birthCertificateNo,
        "national_id_no": nationalIdNo,
        "passport_no": passportNo,
        "phone": phone,
        "alt_phone": altPhone,
        "mobile": mobile,
        "sms_number": smsNumber,
        "email": email,
        "alt_email": altEmail,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "father_name": fatherName,
        "mother_name": motherName,
        "spouse_name": spouseName,
        "etin": etin,
        "blood_group": bloodGroup,
        "emergency_contact": emergencyContact,
        "image": image,
        "bio_media": bioMedia,
        "bio_media_url": bioMediaUrl,
        "bio": bio,
        "children_has": childrenHas,
        "religion": religion,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_relation": emergencyContactRelation,
        "school_name": schoolName,
        "employment": employment?.toJson(),
        "exprience": exprience == null
            ? []
            : List<dynamic>.from(exprience!.map((x) => x.toJson())),
        "tagline": tagline,
        "year_of_experience": yearOfExperience,
        "classes_per_week": classesPerWeek,
        "grade_name": gradeName,
        "professional_profiles": professionalProfiles == null
            ? []
            : List<dynamic>.from(professionalProfiles!.map((x) => x.toJson())),
      };
}

class Employment {
  final int? id;
  final int? employeeId;
  final int? departmentId;
  final int? designationId;
  final dynamic employeeType;
  final EmployeeDe? employeeDepartment;
  final EmployeeDe? employeeDesignation;

  Employment({
    this.id,
    this.employeeId,
    this.departmentId,
    this.designationId,
    this.employeeType,
    this.employeeDepartment,
    this.employeeDesignation,
  });

  factory Employment.fromJson(Map<String, dynamic> json) => Employment(
        id: json["id"],
        employeeId: json["employee_id"],
        departmentId: json["department_id"],
        designationId: json["designation_id"],
        employeeType: json["employee_type"],
        employeeDepartment: json["employee_department"] == null
            ? null
            : EmployeeDe.fromJson(json["employee_department"]),
        employeeDesignation: json["employee_designation"] == null
            ? null
            : EmployeeDe.fromJson(json["employee_designation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "department_id": departmentId,
        "designation_id": designationId,
        "employee_type": employeeType,
        "employee_department": employeeDepartment?.toJson(),
        "employee_designation": employeeDesignation?.toJson(),
      };
}

class EmployeeDe {
  final int? id;
  final String? name;

  EmployeeDe({
    this.id,
    this.name,
  });

  factory EmployeeDe.fromJson(Map<String, dynamic> json) => EmployeeDe(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Exprience {
  final int? id;
  final String? organizationName;
  final String? designation;
  final String? department;
  final int? employeeId;
  final DateTime? startDate;
  final dynamic endDate;
  final int? currentlyWorking;

  Exprience({
    this.id,
    this.organizationName,
    this.designation,
    this.department,
    this.employeeId,
    this.startDate,
    this.endDate,
    this.currentlyWorking,
  });

  factory Exprience.fromJson(Map<String, dynamic> json) => Exprience(
        id: json["id"],
        organizationName: json["organization_name"],
        designation: json["designation"],
        department: json["department"],
        employeeId: json["employee_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        currentlyWorking: json["currently_working"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organization_name": organizationName,
        "designation": designation,
        "department": department,
        "employee_id": employeeId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "currently_working": currentlyWorking,
      };
}

class ProfessionalProfile {
  final int? id;
  final int? userId;
  final String? key;
  final String? value;

  ProfessionalProfile({
    this.id,
    this.userId,
    this.key,
    this.value,
  });

  factory ProfessionalProfile.fromJson(Map<String, dynamic> json) =>
      ProfessionalProfile(
        id: json["id"],
        userId: json["user_id"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "key": key,
        "value": value,
      };
}
