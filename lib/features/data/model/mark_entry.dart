class MarkEntry {
  final String status;
  final String marks;
  final String? content;

  MarkEntry({
    required this.status,
    required this.marks,
    this.content,
  });

  factory MarkEntry.fromJson(Map<String, dynamic> json) => MarkEntry(
        status: json["status"],
        marks: json["marks"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "marks": marks,
        "content": content,
      };
}
