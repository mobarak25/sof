class AssignmentAssignStudent {
  final List<int>? data;

  const AssignmentAssignStudent({
    this.data,
  });

  factory AssignmentAssignStudent.fromJson(Map<String, dynamic> json) =>
      AssignmentAssignStudent(
        data: json["data"] == null
            ? []
            : List<int>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
