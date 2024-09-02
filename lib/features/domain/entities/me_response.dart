class MeResponse {
  final int? id;
  final String? fullname;
  final String? username;
  final int? isFirstLogin;
  final String? email;
  final String? salt;
  final int? isActive;
  final int? userType;
  final int? schoolId;
  final int? schoolGroupId;
  final String? image;
  final dynamic previousId;
  final dynamic cpayId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final School? school;
  final String? domain;
  final Student? student;
  final Employee? employee;

  const MeResponse({
    this.id,
    this.fullname,
    this.username,
    this.isFirstLogin,
    this.email,
    this.salt,
    this.isActive,
    this.userType,
    this.schoolId,
    this.schoolGroupId,
    this.image,
    this.previousId,
    this.cpayId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.school,
    this.domain,
    this.student,
    this.employee,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) => MeResponse(
        id: json["id"],
        fullname: json["fullname"],
        username: json["username"],
        isFirstLogin: json["is_first_login"],
        email: json["email"],
        salt: json["salt"],
        isActive: json["is_active"],
        userType: json["user_type"],
        schoolId: json["school_id"],
        schoolGroupId: json["school_group_id"],
        image: json["image"],
        previousId: json["previous_id"],
        cpayId: json["cpay_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        school: json["school"] == null ? null : School.fromJson(json["school"]),
        domain: json["domain"],
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "username": username,
        "is_first_login": isFirstLogin,
        "email": email,
        "salt": salt,
        "is_active": isActive,
        "user_type": userType,
        "school_id": schoolId,
        "school_group_id": schoolGroupId,
        "image": image,
        "previous_id": previousId,
        "cpay_id": cpayId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "school": school?.toJson(),
        "domain": domain,
        "student": student?.toJson(),
        "employee": employee?.toJson(),
      };
}

class School {
  final int? id;
  final String? name;
  final String? logo;
  final String? phone;
  final String? estd;
  final String? address;
  final String? contactEmail;
  final String? contactPhone;
  final String? contactPerson;
  final dynamic contactNumber;
  final String? webAddress;
  final String? eiinNumber;
  final int? perliamentaryNumber;
  final String? schoolSessionType;
  final String? schoolSession;
  final String? subdomain;
  final int? hasCampus;
  final int? hasShift;
  final int? hasVersion;
  final int? hasClassType;
  final int? hasClassGroup;
  final int? hasSection;
  final int? hasSmsService;
  final int? isAdmissionActive;
  final int? hasAlarmingStudent;
  final int? hasAlarmingEmployee;
  final dynamic srdlCode;
  final int? status;
  final dynamic soName;
  final dynamic soContact;
  final dynamic soEmail;
  final String? attachments;
  final dynamic attendanceApiKey;
  final String? fcmAccessKey;

  const School({
    this.id,
    this.name,
    this.logo,
    this.phone,
    this.estd,
    this.address,
    this.contactEmail,
    this.contactPhone,
    this.contactPerson,
    this.contactNumber,
    this.webAddress,
    this.eiinNumber,
    this.perliamentaryNumber,
    this.schoolSessionType,
    this.schoolSession,
    this.subdomain,
    this.hasCampus,
    this.hasShift,
    this.hasVersion,
    this.hasClassType,
    this.hasClassGroup,
    this.hasSection,
    this.hasSmsService,
    this.isAdmissionActive,
    this.hasAlarmingStudent,
    this.hasAlarmingEmployee,
    this.srdlCode,
    this.status,
    this.soName,
    this.soContact,
    this.soEmail,
    this.attachments,
    this.attendanceApiKey,
    this.fcmAccessKey,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        phone: json["phone"],
        estd: json["estd"],
        address: json["address"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        contactPerson: json["contact_person"],
        contactNumber: json["contact_number"],
        webAddress: json["web_address"],
        eiinNumber: json["eiin_number"],
        perliamentaryNumber: json["perliamentary_number"],
        schoolSessionType: json["school_session_type"],
        schoolSession: json["school_session"],
        subdomain: json["subdomain"],
        hasCampus: json["has_campus"],
        hasShift: json["has_shift"],
        hasVersion: json["has_version"],
        hasClassType: json["has_class_type"],
        hasClassGroup: json["has_class_group"],
        hasSection: json["has_section"],
        hasSmsService: json["has_sms_service"],
        isAdmissionActive: json["is_admission_active"],
        hasAlarmingStudent: json["has_alarming_student"],
        hasAlarmingEmployee: json["has_alarming_employee"],
        srdlCode: json["srdl_code"],
        status: json["status"],
        soName: json["so_name"],
        soContact: json["so_contact"],
        soEmail: json["so_email"],
        attachments: json["attachments"],
        attendanceApiKey: json["attendance_api_key"],
        fcmAccessKey: json["fcm_access_key"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "phone": phone,
        "estd": estd,
        "address": address,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "contact_person": contactPerson,
        "contact_number": contactNumber,
        "web_address": webAddress,
        "eiin_number": eiinNumber,
        "perliamentary_number": perliamentaryNumber,
        "school_session_type": schoolSessionType,
        "school_session": schoolSession,
        "subdomain": subdomain,
        "has_campus": hasCampus,
        "has_shift": hasShift,
        "has_version": hasVersion,
        "has_class_type": hasClassType,
        "has_class_group": hasClassGroup,
        "has_section": hasSection,
        "has_sms_service": hasSmsService,
        "is_admission_active": isAdmissionActive,
        "has_alarming_student": hasAlarmingStudent,
        "has_alarming_employee": hasAlarmingEmployee,
        "srdl_code": srdlCode,
        "status": status,
        "so_name": soName,
        "so_contact": soContact,
        "so_email": soEmail,
        "attachments": attachments,
        "attendance_api_key": attendanceApiKey,
        "fcm_access_key": fcmAccessKey,
      };
}

class Student {
  final int? id;
  final int? userId;
  final int? batchId;
  final int? studentCategoryId;
  final int? nationalityId;
  final String? admissionNumber;
  final String? email;
  final String? mobile;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? admissionDate;
  final String? dateOfBirth;
  final String? realBirthdate;
  final String? birthCertificateNo;
  final int? gender;
  final String? bloodGroup;
  final String? religion;
  final String? smsNumber;
  final String? presentAddress;
  final String? permanentAddress;
  final int? isActive;
  final dynamic inActiveAt;
  final String? classRollNo;
  final int? combinedEnabled;
  final dynamic imageUrl;
  final dynamic remarks;
  final dynamic previousId;
  final dynamic cpayId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  const Student({
    this.id,
    this.userId,
    this.batchId,
    this.studentCategoryId,
    this.nationalityId,
    this.admissionNumber,
    this.email,
    this.mobile,
    this.firstName,
    this.middleName,
    this.lastName,
    this.admissionDate,
    this.dateOfBirth,
    this.realBirthdate,
    this.birthCertificateNo,
    this.gender,
    this.bloodGroup,
    this.religion,
    this.smsNumber,
    this.presentAddress,
    this.permanentAddress,
    this.isActive,
    this.inActiveAt,
    this.classRollNo,
    this.combinedEnabled,
    this.imageUrl,
    this.remarks,
    this.previousId,
    this.cpayId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        userId: json["user_id"],
        batchId: json["batch_id"],
        studentCategoryId: json["student_category_id"],
        nationalityId: json["nationality_id"],
        admissionNumber: json["admission_number"],
        email: json["email"],
        mobile: json["mobile"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        admissionDate: json["admission_date"],
        dateOfBirth: json["date_of_birth"],
        realBirthdate: json["real_birthdate"],
        birthCertificateNo: json["birth_certificate_no"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        religion: json["religion"],
        smsNumber: json["sms_number"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        isActive: json["is_active"],
        inActiveAt: json["in_active_at"],
        classRollNo: json["class_roll_no"],
        combinedEnabled: json["combined_enabled"],
        imageUrl: json["image_url"],
        remarks: json["remarks"],
        previousId: json["previous_id"],
        cpayId: json["cpay_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "batch_id": batchId,
        "student_category_id": studentCategoryId,
        "nationality_id": nationalityId,
        "admission_number": admissionNumber,
        "email": email,
        "mobile": mobile,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "admission_date": admissionDate,
        "date_of_birth": dateOfBirth,
        "real_birthdate": realBirthdate,
        "birth_certificate_no": birthCertificateNo,
        "gender": gender,
        "blood_group": bloodGroup,
        "religion": religion,
        "sms_number": smsNumber,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "is_active": isActive,
        "in_active_at": inActiveAt,
        "class_roll_no": classRollNo,
        "combined_enabled": combinedEnabled,
        "image_url": imageUrl,
        "remarks": remarks,
        "previous_id": previousId,
        "cpay_id": cpayId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}

class Employee {
  final int? id;
  final int? userId;
  final String? fullName;
  final String? employeeNumber;
  final int? employeeCategoryId;
  final String? shortCode;
  final String? gender;
  final int? maritalStatus;
  final String? dateOfBirth;
  final dynamic image;
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
  final int? isDisabled;
  final dynamic presentAddress;
  final dynamic permanentAddress;
  final dynamic fatherName;
  final dynamic motherName;
  final dynamic spouseName;
  final dynamic etin;
  final dynamic bloodGroup;
  final dynamic emergencyContact;
  final dynamic bioId;
  final dynamic bioMedia;
  final dynamic bioMediaUrl;
  final dynamic bio;
  final int? childrenHas;
  final dynamic salaryAccountNo;
  final dynamic pfAccountNo;
  final dynamic salaryReportSerial;
  final String? religion;
  final int? userType;
  final dynamic employeeGradeId;
  final dynamic emergencyContactName;
  final dynamic salaryGradeId;
  final dynamic salaryYear;
  final dynamic emergencyContactRelation;
  final dynamic disableDetails;
  final int? isPrincipal;
  final dynamic previousId;
  final dynamic cpayId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  Employee({
    this.id,
    this.userId,
    this.fullName,
    this.employeeNumber,
    this.employeeCategoryId,
    this.shortCode,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.image,
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
    this.isDisabled,
    this.presentAddress,
    this.permanentAddress,
    this.fatherName,
    this.motherName,
    this.spouseName,
    this.etin,
    this.bloodGroup,
    this.emergencyContact,
    this.bioId,
    this.bioMedia,
    this.bioMediaUrl,
    this.bio,
    this.childrenHas,
    this.salaryAccountNo,
    this.pfAccountNo,
    this.salaryReportSerial,
    this.religion,
    this.userType,
    this.employeeGradeId,
    this.emergencyContactName,
    this.salaryGradeId,
    this.salaryYear,
    this.emergencyContactRelation,
    this.disableDetails,
    this.isPrincipal,
    this.previousId,
    this.cpayId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
        fullName: json["full_name"],
        employeeNumber: json["employee_number"],
        employeeCategoryId: json["employee_category_id"],
        shortCode: json["short_code"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        dateOfBirth: json["date_of_birth"],
        image: json["image"],
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
        isDisabled: json["is_disabled"],
        presentAddress: json["present_address"],
        permanentAddress: json["permanent_address"],
        fatherName: json["father_name"],
        motherName: json["mother_name"],
        spouseName: json["spouse_name"],
        etin: json["etin"],
        bloodGroup: json["blood_group"],
        emergencyContact: json["emergency_contact"],
        bioId: json["bio_id"],
        bioMedia: json["bio_media"],
        bioMediaUrl: json["bio_media_url"],
        bio: json["bio"],
        childrenHas: json["children_has"],
        salaryAccountNo: json["salary_account_no"],
        pfAccountNo: json["pf_account_no"],
        salaryReportSerial: json["salary_report_serial"],
        religion: json["religion"],
        userType: json["user_type"],
        employeeGradeId: json["employee_grade_id"],
        emergencyContactName: json["emergency_contact_name"],
        salaryGradeId: json["salary_grade_id"],
        salaryYear: json["salary_year"],
        emergencyContactRelation: json["emergency_contact_relation"],
        disableDetails: json["disable_details"],
        isPrincipal: json["is_principal"],
        previousId: json["previous_id"],
        cpayId: json["cpay_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "full_name": fullName,
        "employee_number": employeeNumber,
        "employee_category_id": employeeCategoryId,
        "short_code": shortCode,
        "gender": gender,
        "marital_status": maritalStatus,
        "date_of_birth": dateOfBirth,
        "image": image,
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
        "is_disabled": isDisabled,
        "present_address": presentAddress,
        "permanent_address": permanentAddress,
        "father_name": fatherName,
        "mother_name": motherName,
        "spouse_name": spouseName,
        "etin": etin,
        "blood_group": bloodGroup,
        "emergency_contact": emergencyContact,
        "bio_id": bioId,
        "bio_media": bioMedia,
        "bio_media_url": bioMediaUrl,
        "bio": bio,
        "children_has": childrenHas,
        "salary_account_no": salaryAccountNo,
        "pf_account_no": pfAccountNo,
        "salary_report_serial": salaryReportSerial,
        "religion": religion,
        "user_type": userType,
        "employee_grade_id": employeeGradeId,
        "emergency_contact_name": emergencyContactName,
        "salary_grade_id": salaryGradeId,
        "salary_year": salaryYear,
        "emergency_contact_relation": emergencyContactRelation,
        "disable_details": disableDetails,
        "is_principal": isPrincipal,
        "previous_id": previousId,
        "cpay_id": cpayId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
