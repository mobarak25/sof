import 'dart:async';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_cancel_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/create_meeting.dart';
import 'package:school_of_future/features/domain/entities/assignment_assign_student_response.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/meeting_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'meeting_create_event.dart';
part 'meeting_create_state.dart';

class MeetingCreateBloc extends Bloc<MeetingCreateEvent, MeetingCreateState> {
  MeetingCreateBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(MeetingCreateInitial()) {
    on<MeetingIdForEdit>(_meetingIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<StartDate>(_startDate);
    on<StartTime>(_startTime);
    on<EndTime>(_endTime);
    on<ChangeMeetingLink>(_changeMeetingLink);
    on<AddAgenda>(_addAgenda);
    on<DeleteAgenda>(_deleteAgenda);
    on<GetMeetingType>(_getMeetingType);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSectionList>(_selectSectionList);
    on<BackWithUnselected>(_backWithUnselected);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);
    on<AddData>(_addData);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _meetingIdForEdit(
      MeetingIdForEdit event, Emitter<MeetingCreateState> emit) async {
    emit(state.copyWith(meetingId: event.meetingId));
    print("meeting id:=========== ${event.meetingId}");

    if (event.meetingId != -1) {
      final details = await _apiRepo.get<MeetingDetails>(
        endpoint: teacherMeetingDetailsEndPoint(meetingId: event.meetingId),
      );

      if (details != null) {
        emit(state.copyWith(meetingDetails: details));
        add(SelectVersionId(id: state.meetingDetails.data!.batch!.versionId!));
        add(SelectClassId(id: state.meetingDetails.data!.batch!.classId!));
      }
    }
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<MeetingCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _startDate(StartDate event, Emitter<MeetingCreateState> emit) {
    final date = getDate(value: event.startDate, formate: "yyyy-MM-dd");
    emit(state.copyWith(date: date));
  }

  FutureOr<void> _startTime(StartTime event, Emitter<MeetingCreateState> emit) {
    emit(state.copyWith(startTime: event.startTime));
  }

  FutureOr<void> _endTime(EndTime event, Emitter<MeetingCreateState> emit) {
    emit(state.copyWith(endTime: event.endTime));
  }

  FutureOr<void> _changeMeetingLink(
      ChangeMeetingLink event, Emitter<MeetingCreateState> emit) {
    emit(state.copyWith(link: event.link));
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<MeetingCreateState> emit) async {
    final versionList = await _apiRepo.get<GetBacthAsSections>(
        endpoint: getBatchAsSectionsEndPoint);

    List<DropdownItem> list = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (versionList != null) {
      for (int i = 0; i < versionList.data!.length; i++) {
        list.add(
          DropdownItem(
              name: versionList.data![i].versionName!,
              value: versionList.data![i].versionId),
        );
      }

      emit(state.copyWith(versionList: list, bacthAsSection: versionList));
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<MeetingCreateState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> classList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedVersionId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == event.id) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            classList.add(DropdownItem(
                name: data[i].classes![j].className!,
                value: data[i].classes![j].classId!));
          }
        }
      }

      emit(state.copyWith(
        selectedVersionId: event.id,
        setClass: true,
        setSection: true,
        selectedClassId: -1,
        selectSectionId: -1,
        classList: classList,
        sectionList: [],
        assignToBatchId: [],
        batchWiseStudent: [],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<MeetingCreateState> emit) {
    final data = state.bacthAsSection.data!;

    List<DropDownValueModel> sectionList = [];

    if (event.id != state.selectedClassId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == state.selectedVersionId) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            if (data[i].classes![j].classId == event.id) {
              emit(state.copyWith(
                  selecteClassName: data[i].classes![j].className));
              final sections = data[i].classes![j].subjects![0].sections!;
              for (int k = 0; k < sections.length; k++) {
                sectionList.add(DropDownValueModel(
                    name: sections[k].sectionName!,
                    value: sections[k].batchId!));
              }
            }
          }
        }
      }

      emit(state.copyWith(
        selectedClassId: event.id,
        setSection: true,
        sectionList: sectionList,
        assignToBatchId: [],
        batchWiseStudent: [],
      ));
    }
  }

  FutureOr<void> _selectSectionList(
      SelectSectionList event, Emitter<MeetingCreateState> emit) async {
    List<int> batchIdList = [];
    List<String> batchNames = [];
    for (int i = 0; i < event.sectionList.length; i++) {
      batchIdList.add(event.sectionList[i].value);
      batchNames.add(event.sectionList[i].name);
    }
    emit(state.copyWith(
      assignToBatchId: batchIdList,
      selectedBatchName: batchNames,
      batchLoading: true,
    ));

    List<BatchWiseStudent> batchWiseStudentList = [];
    List<List<CheckUncheckStudents>> listCheckUncheck = [];
    List<CheckUncheckStudents> checkUncheck = [];

    for (int i = 0; i < state.assignToBatchId.length; i++) {
      final student = await _apiRepo.get<BatchWiseStudent>(
          endpoint: getBatchWiseStudentsByBatchIdEndpoint(
              batchId: state.assignToBatchId[i]));

      if (student != null && state.meetingId == -1) {
        batchWiseStudentList.add(student);

        if (student.data != null) {
          for (int j = 0; j < student.data!.length; j++) {
            checkUncheck.add(CheckUncheckStudents(
              id: student.data![j].id!,
              isChecked: true,
              name: student.data![j].name!,
              admissionRoll: student.data![j].admissionNumber!,
            ));
          }
          listCheckUncheck.add(checkUncheck);
          checkUncheck = [];
        }
      } else {
        batchWiseStudentList.add(student!);
        if (student.data != null) {
          for (int j = 0; j < student.data!.length; j++) {
            if (state.meetingDetails.data!.meetingStudents!
                .contains(student.data![j].id)) {
              checkUncheck.add(CheckUncheckStudents(
                id: student.data![j].id!,
                isChecked: true,
                name: student.data![j].name!,
                admissionRoll: student.data![j].admissionNumber!,
              ));
            } else {
              checkUncheck.add(CheckUncheckStudents(
                id: student.data![j].id!,
                isChecked: false,
                name: student.data![j].name!,
                admissionRoll: student.data![j].admissionNumber!,
              ));
            }
          }
          listCheckUncheck.add(checkUncheck);
          checkUncheck = [];
        }
      }
    }

    emit(state.copyWith(
      batchWiseStudent: batchWiseStudentList,
      // tempBatchWiseStudent: batchWiseStudentList,
      batchLoading: false,
      listOfCheckUncheckStudent: listCheckUncheck,
    ));
  }

  FutureOr<void> _backWithUnselected(
      BackWithUnselected event, Emitter<MeetingCreateState> emit) {
    List<List<CheckUncheckStudents>> updateStudents =
        state.listOfCheckUncheckStudent;

    updateStudents[event.index] = event.students;
    emit(state.copyWith(listOfCheckUncheckStudent: updateStudents));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<MeetingCreateState> emit) async {
    List<int> studentList = [];
    List<String> adendaList = [];

    for (int i = 0; i < state.listOfCheckUncheckStudent.length; i++) {
      for (int j = 0; j < state.listOfCheckUncheckStudent[i].length; j++) {
        if (state.listOfCheckUncheckStudent[i][j].isChecked) {
          studentList.add(state.listOfCheckUncheckStudent[i][j].id);
        }
      }
    }

    for (int i = 0; i < state.agenda.length; i++) {
      adendaList.add(state.agenda[i].textEditingController.text);
    }

    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.post<DefaultResponse>(
        endpoint: state.meetingId != -1
            ? teacherMeetingDetailsEndPoint(meetingId: state.meetingId)
            : teacherMeetingEndPoint,
        body: CreateMeeting(
          title: state.title,
          description: event.content,
          status: event.isDraft ? 0 : 1,
          meetingType: state.meetingType,
          date: state.date,
          startTime: state.startTime,
          endTime: state.endTime,
          agenda: adendaList,
          meetingLink: state.link,
          meetingStudents: studentList,
          meetingBatch: state.assignToBatchId,
          method: state.meetingId == -1 ? "POST" : "PUT",
        ),
      );

      if (create != null) {
        _iFlutterNavigator.pop();
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            teacherMeetingListScreen, ModalRoute.withName('/'));
        ShowSnackBar(message: create.message!, navigator: _iFlutterNavigator);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToCreate event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.title, focusNode: event.titleFocusnode),
      FormItem(text: state.date, focusNode: event.dateFocusnode),
      FormItem(text: state.startTime, focusNode: event.startTimeFocusnode),
      FormItem(text: state.endTime, focusNode: event.endTimeFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.title.isEmpty ||
        state.date.isEmpty ||
        state.startTime.isEmpty ||
        state.endTime.isEmpty ||
        (state.meetingType == 1 && state.link.isEmpty) ||
        state.assignToBatchId.isEmpty) {
      return false;
    }
    return true;
  }

  FutureOr<void> _addAgenda(AddAgenda event, Emitter<MeetingCreateState> emit) {
    emit(
      state.copyWith(
          agenda: List.from(state.agenda)
            ..add(AgendaInput(
              textEditingController: TextEditingController(),
              focusnode: FocusNode(),
            ))),
    );
  }

  FutureOr<void> _deleteAgenda(
      DeleteAgenda event, Emitter<MeetingCreateState> emit) {
    emit(
        state.copyWith(agenda: List.from(state.agenda)..removeAt(event.index)));
  }

  FutureOr<void> _getMeetingType(
      GetMeetingType event, Emitter<MeetingCreateState> emit) {
    emit(state.copyWith(meetingType: event.type));
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<MeetingCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      Navigator.popUntil(_iFlutterNavigator.context, (route) => route.isFirst);
    });
  }

  FutureOr<void> _addData(AddData event, Emitter<MeetingCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        date: getDate(value: event.startDate, formate: "yyyy-MM-dd"),
        agenda: event.agenda,
        meetingType: event.meetingType,
        link: event.link,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        startTime: event.startTime,
        endTime: event.endTime,
        isFirstTime: false,
      ));
    }
  }
}
