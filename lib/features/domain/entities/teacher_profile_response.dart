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
  final String? gender;
  final int? maritalStatus;
  final String? dob;
  final dynamic signature;
  final dynamic birthCertificateNo;
  final String? nationalIdNo;
  final dynamic passportNo;
  final dynamic phone;
  final dynamic altPhone;
  final String? mobile;
  final String? smsNumber;
  final dynamic email;
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
  final String? religion;
  final dynamic emergencyContactName;
  final dynamic emergencyContactRelation;
  final String? schoolName;
  final String? employeeType;
  final String? departmentName;
  final String? designation;
  final String? tagline;
  final int? yearOfExperience;
  final dynamic classesPerWeek;
  final dynamic gradeName;
  final List<dynamic>? professionalProfiles;

  Data({
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
    this.employeeType,
    this.departmentName,
    this.designation,
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
        employeeType: json["employee_type"],
        departmentName: json["department_name"],
        designation: json["designation"],
        tagline: json["tagline"],
        yearOfExperience: json["year_of_experience"],
        classesPerWeek: json["classes_per_week"],
        gradeName: json["grade_name"],
        professionalProfiles: json["professional_profiles"] == null
            ? []
            : List<dynamic>.from(json["professional_profiles"]!.map((x) => x)),
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
        "employee_type": employeeType,
        "department_name": departmentName,
        "designation": designation,
        "tagline": tagline,
        "year_of_experience": yearOfExperience,
        "classes_per_week": classesPerWeek,
        "grade_name": gradeName,
        "professional_profiles": professionalProfiles == null
            ? []
            : List<dynamic>.from(professionalProfiles!.map((x) => x)),
      };
}
