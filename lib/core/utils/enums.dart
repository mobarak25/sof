class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

enum Forms { initial, submitted, inProgress, invalid, valid, success }

enum ChipsType { Approved, Approve, Cancel, Processing }

enum AttenddanceType {
  Absent,
  ELeft,
  Early,
  HalfDay,
  Holiday,
  Late,
  Present,
  ONill,
  OnLeave,
  Travel,
  Weekoff
}

enum PresentEnum { ELeft, Early, HalfDay, Late, Present, Travel }
