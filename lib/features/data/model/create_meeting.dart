class CreateMeeting {
  final String title;
  final String description;
  final int status;
  final int meetingType;
  final String date;
  final String startTime;
  final String endTime;
  final List<String> agenda;
  final List<int> meetingStudents;
  final List<int> meetingBatch;
  final String meetingLink;
  final String method;

  CreateMeeting({
    required this.title,
    required this.description,
    required this.status,
    required this.meetingType,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.agenda,
    required this.meetingStudents,
    required this.meetingBatch,
    required this.meetingLink,
    required this.method,
  });

  factory CreateMeeting.fromJson(Map<String, dynamic> json) => CreateMeeting(
        title: json["title"],
        description: json["description"],
        status: json["status"],
        meetingType: json["meeting_type"],
        date: json["date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        agenda: List<String>.from(json["agenda"].map((x) => x)),
        meetingStudents: List<int>.from(json["meeting_students"].map((x) => x)),
        meetingBatch: List<int>.from(json["meeting_batch"].map((x) => x)),
        meetingLink: json["meeting_link"],
        method: json["_method"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "status": status,
        "meeting_type": meetingType,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "agenda": List<dynamic>.from(agenda.map((x) => x)),
        "meeting_students": List<dynamic>.from(meetingStudents.map((x) => x)),
        "meeting_batch": List<dynamic>.from(meetingBatch.map((x) => x)),
        "meeting_link": meetingLink,
        "_method": method,
      };
}
