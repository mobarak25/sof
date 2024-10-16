part of 'teacher_apply_leave_bloc.dart';

class TeacherApplyLeaveState extends Equatable {
  const TeacherApplyLeaveState({
    this.leaveId = -1,
    this.loginId = '',
    this.loading = false,
    this.isFirstTime = true,
    this.forms = Forms.initial,
    this.title = '',
    this.leaveType = -1,
    this.startDate = '',
    this.endDate = '',
    this.dateCount = 0,
    this.tempDateCount = 0,
    this.isHalfDay = false,
    this.isEmergency = false,
    this.description = '',
    this.fileList = const [],
    this.leaveList = const LeaveTypes(),
    this.leaveDropdown = const [DropdownItem(name: "Select", value: -1)],
    this.details = const TeacherLeaveDetails(),
  });

  final int leaveId;
  final String loginId;
  final bool loading;
  final bool isFirstTime;
  final Forms forms;
  final String title;
  final dynamic leaveType;
  final String startDate;
  final String endDate;
  final num dateCount;
  final num tempDateCount;
  final bool isHalfDay;
  final bool isEmergency;
  final String description;
  final List<File> fileList;
  final LeaveTypes leaveList;
  final List<DropdownItem> leaveDropdown;
  final TeacherLeaveDetails details;

  TeacherApplyLeaveState copyWith({
    int? leaveId,
    String? loginId,
    bool? loading,
    bool? isFirstTime,
    Forms? forms,
    String? title,
    dynamic leaveType,
    String? startDate,
    String? endDate,
    num? dateCount,
    num? tempDateCount,
    bool? isHalfDay,
    bool? isEmergency,
    String? description,
    List<File>? fileList,
    LeaveTypes? leaveList,
    List<DropdownItem>? leaveDropdown,
    TeacherLeaveDetails? details,
  }) {
    return TeacherApplyLeaveState(
      leaveId: leaveId ?? this.leaveId,
      loginId: loginId ?? this.loginId,
      loading: loading ?? this.loading,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      forms: forms ?? this.forms,
      title: title ?? this.title,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateCount: dateCount ?? this.dateCount,
      tempDateCount: tempDateCount ?? this.tempDateCount,
      isHalfDay: isHalfDay ?? this.isHalfDay,
      isEmergency: isEmergency ?? this.isEmergency,
      description: description ?? this.description,
      fileList: fileList ?? this.fileList,
      leaveList: leaveList ?? this.leaveList,
      leaveDropdown: leaveDropdown ?? this.leaveDropdown,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [
        leaveId,
        loginId,
        loading,
        isFirstTime,
        forms,
        title,
        leaveType,
        startDate,
        endDate,
        dateCount,
        tempDateCount,
        isHalfDay,
        isEmergency,
        description,
        fileList,
        leaveList,
        leaveDropdown,
        details,
      ];
}

final class TeacherApplyLeaveInitial extends TeacherApplyLeaveState {}
