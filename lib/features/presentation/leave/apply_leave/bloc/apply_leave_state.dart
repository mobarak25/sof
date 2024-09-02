part of 'apply_leave_bloc.dart';

class ApplyLeaveState extends Equatable {
  const ApplyLeaveState({
    this.title = '',
    this.leaveType = 0,
    this.startDate = '',
    this.endDate = '',
    this.dateCount = 0,
    this.tempDateCount = 0,
    this.isHalfDay = false,
    this.description = '',
    this.leaveFile = const [],
    this.fileList = const [],
  });

  final String title;
  final dynamic leaveType;
  final String startDate;
  final String endDate;
  final num dateCount;
  final num tempDateCount;
  final bool isHalfDay;
  final String description;
  final List<ImageFile> leaveFile;
  final List<File> fileList;

  ApplyLeaveState copyWith({
    String? title,
    dynamic leaveType,
    String? startDate,
    String? endDate,
    num? dateCount,
    num? tempDateCount,
    bool? isHalfDay,
    String? description,
    List<ImageFile>? leaveFile,
    List<File>? fileList,
  }) {
    return ApplyLeaveState(
      title: title ?? this.title,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateCount: dateCount ?? this.dateCount,
      tempDateCount: tempDateCount ?? this.tempDateCount,
      isHalfDay: isHalfDay ?? this.isHalfDay,
      description: description ?? this.description,
      leaveFile: leaveFile ?? this.leaveFile,
      fileList: fileList ?? this.fileList,
    );
  }

  @override
  List<Object> get props => [
        title,
        leaveType,
        startDate,
        endDate,
        dateCount,
        tempDateCount,
        isHalfDay,
        description,
        leaveFile,
        fileList,
      ];
}

final class ApplyLeaveInitial extends ApplyLeaveState {}
