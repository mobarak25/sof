import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_time_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/core/widgets/time_picker.dart';
import 'package:school_of_future/features/presentation/exam/teacher_exam_create/bloc/teacher_exam_create_bloc.dart';

class TeacherExamCreateScreen extends StatelessWidget {
  const TeacherExamCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TeacherExamCreateBloc>();

    final examDateFocusnode = FocusNode();
    final startTimeFocusnode = FocusNode();
    final endTimeFocusnode = FocusNode();
    final maxMarkFocusnode = FocusNode();
    final convertMarkFocusnode = FocusNode();
    final passMarkFocusnode = FocusNode();

    final examDateController = TextEditingController();
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();
    final maxMarkController = TextEditingController();
    final convertMarkController = TextEditingController();
    final passMarkController = TextEditingController();

    return BlocBuilder<TeacherExamCreateBloc, TeacherExamCreateState>(
      builder: (context, state) {
        examDateController.text = state.examDate;
        startTimeController.text = state.startTime;
        endTimeController.text = state.endTime;
        maxMarkController.text = state.maxMark;
        convertMarkController.text = state.convertMark;
        passMarkController.text = state.passMark;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: context.tr(LocaleKeys.createExam),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: state.bacthAsSection.data != null
                ? ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.date.tr(),
                            hintText: "yyyy-mm-dd",
                            textInputType: TextInputType.number,
                            borderColor: bGray12,
                            focusNode: examDateFocusnode,
                            controller: examDateController,
                            isReadOnly: true,
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              size: 30,
                              color: bGray32,
                            ),
                            onChanged: (String value) {},
                            onTouch: () async {
                              examDateController.text =
                                  await showDateTimePickerDialog(context,
                                          initialdate: state.examDate) ??
                                      '';
                              bloc.add(
                                  ExamDate(examDate: examDateController.text));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.examDate.isEmpty
                                ? LocaleKeys.examDate.tr()
                                : '',
                          ),
                          const Gap(15),
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldB(
                                  isMandatory: true,
                                  fieldTitle: LocaleKeys.startTime.tr(),
                                  hintText: LocaleKeys.selectTime.tr(),
                                  borderColor: bGray12,
                                  focusNode: startTimeFocusnode,
                                  controller: startTimeController,
                                  isReadOnly: true,
                                  suffixIcon: const Icon(
                                    Icons.schedule,
                                    size: 30,
                                    color: bGray32,
                                  ),
                                  onChanged: (String value) {},
                                  onTouch: () async {
                                    startTimeController.text =
                                        await showTimePickerDialog(context,
                                                initialTime: convertToDateTime(
                                                    state.startTime)) ??
                                            '';

                                    bloc.add(StartTime(
                                        startTime: startTimeController.text));
                                  },
                                  errorText: state.forms == Forms.invalid &&
                                          state.startTime.isEmpty
                                      ? LocaleKeys.noStartTime.tr()
                                      : '',
                                ),
                              ),
                              const Gap(20),
                              Expanded(
                                child: TextFieldB(
                                  isMandatory: true,
                                  fieldTitle: LocaleKeys.endTime.tr(),
                                  hintText: LocaleKeys.selectTime.tr(),
                                  borderColor: bGray12,
                                  focusNode: endTimeFocusnode,
                                  controller: endTimeController,
                                  isReadOnly: true,
                                  suffixIcon: const Icon(
                                    Icons.schedule,
                                    size: 30,
                                    color: bGray32,
                                  ),
                                  onChanged: (String value) {},
                                  onTouch: () async {
                                    endTimeController.text =
                                        await showTimePickerDialog(context,
                                                initialTime: convertToDateTime(
                                                    state.endTime)) ??
                                            '';
                                    bloc.add(EndTime(
                                        endTime: endTimeController.text));
                                  },
                                  errorText: state.forms == Forms.invalid &&
                                          state.endTime.isEmpty
                                      ? LocaleKeys.noEndTime.tr()
                                      : '',
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          DropdownFieldB(
                            dropdownHeight: 50,
                            label: LocaleKeys.version.tr(),
                            labelColor: bBlack,
                            dropDownValue: state.selectedVersionId,
                            selected: (dynamic type) {
                              bloc.add(SelectVersionId(id: type));
                            },
                            items: state.versionList,
                          ),
                          if (state.forms == Forms.invalid &&
                              state.selectedVersionId == -1)
                            TextB(
                                text: LocaleKeys.selectVersion.tr(),
                                fontColor: bRed),
                          const Gap(10),
                          DropdownFieldB(
                            dropdownHeight: 50,
                            setState: state.setClass,
                            label: LocaleKeys.classStr.tr(),
                            labelColor: bBlack,
                            dropDownValue: state.selectedClassId,
                            selected: (dynamic type) {
                              bloc.add(SelectClassId(id: type));
                            },
                            items: state.classList,
                          ),
                          if (state.forms == Forms.invalid &&
                              state.selectedClassId == -1)
                            TextB(
                                text: LocaleKeys.selectClass.tr(),
                                fontColor: bRed),
                          const Gap(10),
                          DropdownFieldB(
                            dropdownHeight: 50,
                            label: LocaleKeys.subject.tr(),
                            labelColor: bBlack,
                            setState: state.setSubject,
                            dropDownValue: state.selectedSubjectId,
                            selected: (dynamic type) {
                              bloc.add(SelectSubjectId(id: type));
                            },
                            items: state.subjectList,
                          ),
                          if (state.forms == Forms.invalid &&
                              state.selectedSubjectId == -1)
                            TextB(
                                text: LocaleKeys.selectSubject.tr(),
                                fontColor: bRed),
                          const Gap(10),
                          DropdownFieldB(
                            dropdownHeight: 50,
                            label: LocaleKeys.section.tr(),
                            labelColor: bBlack,
                            setState: state.setSection,
                            dropDownValue: state.selectSectionId,
                            selected: (dynamic type) {
                              bloc.add(SelectSectionId(id: type));
                            },
                            items: state.sectionList,
                          ),
                          if (state.forms == Forms.invalid &&
                              state.selectSectionId == -1)
                            TextB(
                                text: LocaleKeys.selectSection.tr(),
                                fontColor: bRed),
                          const Gap(10),
                          DropdownFieldB(
                            dropdownHeight: 50,
                            label: LocaleKeys.examGroup.tr(),
                            labelColor: bBlack,
                            setState: state.setGroup,
                            dropDownValue: state.selectedExamGorupId,
                            selected: (dynamic type) {
                              bloc.add(SelectGroupId(id: type));
                            },
                            items: !state.loading ? state.groupList : [],
                          ),
                          if (state.forms == Forms.invalid &&
                              state.selectedExamGorupId == -1)
                            TextB(
                                text: LocaleKeys.enterExamGroup.tr(),
                                fontColor: bRed),
                          const Gap(10),
                          DropdownFieldB(
                            dropdownHeight: 50,
                            label: LocaleKeys.examTerm.tr(),
                            labelColor: bBlack,
                            setState: state.setTerm,
                            dropDownValue: state.selectTermId,
                            selected: (dynamic type) {
                              bloc.add(SelectTermId(id: type));
                            },
                            items: !state.loading ? state.termList : [],
                          ),
                          if (state.forms == Forms.invalid &&
                              state.selectTermId == -1)
                            TextB(
                                text: LocaleKeys.enterExamTerm.tr(),
                                fontColor: bRed),
                          const Gap(10),
                          TextFieldB(
                            textInputType: TextInputType.number,
                            fieldTitle: LocaleKeys.maxMark.tr(),
                            hintText: LocaleKeys.enterMark.tr(),
                            borderColor: bGray12,
                            focusNode: maxMarkFocusnode,
                            controller: maxMarkController,
                            onChanged: (String value) {
                              bloc.add(ChangeMaxMark(maxMark: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.maxMark.isEmpty
                                ? LocaleKeys.enterMark.tr()
                                : '',
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldB(
                                  textInputType: TextInputType.number,
                                  fieldTitle: LocaleKeys.convertMark.tr(),
                                  hintText: LocaleKeys.enterMark.tr(),
                                  borderColor: bGray12,
                                  focusNode: convertMarkFocusnode,
                                  controller: convertMarkController,
                                  onChanged: (String value) {
                                    bloc.add(
                                        ChangeConvertMark(convertMark: value));
                                  },
                                  errorText: state.forms == Forms.invalid &&
                                          state.convertMark.isEmpty
                                      ? LocaleKeys.enterMark.tr()
                                      : '',
                                ),
                              ),
                              const Gap(15),
                              Expanded(
                                child: TextFieldB(
                                  textInputType: TextInputType.number,
                                  fieldTitle: LocaleKeys.passMark.tr(),
                                  hintText: LocaleKeys.enterMark.tr(),
                                  borderColor: bGray12,
                                  focusNode: passMarkFocusnode,
                                  controller: passMarkController,
                                  onChanged: (String value) {
                                    bloc.add(ChangePassMark(passMark: value));
                                  },
                                  errorText: state.forms == Forms.invalid &&
                                          state.passMark.isEmpty
                                      ? LocaleKeys.enterMark.tr()
                                      : '',
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Row(
                            children: [
                              Expanded(
                                child: ButtonB(
                                  heigh: 60,
                                  text: state.examId == -1
                                      ? LocaleKeys.create.tr()
                                      : LocaleKeys.save.tr(),
                                  press: () {
                                    bloc.add(
                                      PressToCreate(
                                        examDateFocusnode: examDateFocusnode,
                                        startTimeFocusnode: startTimeFocusnode,
                                        endTimeFocusnode: endTimeFocusnode,
                                        maxMarkFocusnode: maxMarkFocusnode,
                                        convertMarkFocusnode:
                                            convertMarkFocusnode,
                                        passMarkFocusnode: passMarkFocusnode,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const Gap(15),
                              Expanded(
                                child: ButtonB(
                                  heigh: 60,
                                  bgColor: bGray12,
                                  textColor: bGray52,
                                  text: LocaleKeys.cancel.tr(),
                                  press: () {
                                    bloc.add(
                                      PressToCancel(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                        ],
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
