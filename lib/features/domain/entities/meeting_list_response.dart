class MeetingList {
  final int? currentPage;
  final List<MeetingItem>? data;
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

  const MeetingList({
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

  factory MeetingList.fromJson(Map<String, dynamic> json) => MeetingList(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<MeetingItem>.from(
                json["data"]!.map((x) => MeetingItem.fromJson(x))),
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

class MeetingItem {
  final int? id;
  final int? userId;
  final int? employeeId;
  final String? title;
  final String? description;
  final int? meetingType;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? meetingLink;
  final int? status;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;
  final MeetingMembers? meetingMembers;
  final List<Agenda>? agenda;
  final Employee? employee;

  const MeetingItem({
    this.id,
    this.userId,
    this.employeeId,
    this.title,
    this.description,
    this.meetingType,
    this.date,
    this.startTime,
    this.endTime,
    this.meetingLink,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.meetingMembers,
    this.agenda,
    this.employee,
  });

  factory MeetingItem.fromJson(Map<String, dynamic> json) => MeetingItem(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        title: json["title"],
        description: json["description"],
        meetingType: json["meeting_type"],
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        meetingLink: json["meeting_link"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        meetingMembers: json["meeting_members"] == null
            ? null
            : MeetingMembers.fromJson(json["meeting_members"]),
        agenda: json["agenda"] == null
            ? []
            : List<Agenda>.from(json["agenda"]!.map((x) => Agenda.fromJson(x))),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "title": title,
        "description": description,
        "meeting_type": meetingType,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "meeting_link": meetingLink,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "meeting_members": meetingMembers?.toJson(),
        "agenda": agenda == null
            ? []
            : List<dynamic>.from(agenda!.map((x) => x.toJson())),
        "employee": employee?.toJson(),
      };
}

class Agenda {
  final int? id;
  final int? meetingId;
  final String? title;

  const Agenda({
    this.id,
    this.meetingId,
    this.title,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json["id"],
        meetingId: json["meeting_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meeting_id": meetingId,
        "title": title,
      };
}

class Employee {
  final int? id;
  final String? fullName;
  final String? image;

  const Employee({
    this.id,
    this.fullName,
    this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        fullName: json["full_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "image": image,
      };
}

class MeetingMembers {
  final String? name;
  final int? more;

  MeetingMembers({
    this.name,
    this.more,
  });

  factory MeetingMembers.fromJson(Map<String, dynamic> json) => MeetingMembers(
        name: json["name"],
        more: json["more"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "more": more,
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  const Link({
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
