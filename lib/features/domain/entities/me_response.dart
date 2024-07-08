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

  const MeResponse(
      {this.id,
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
      this.domain});

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

  School({
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
