import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_time_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/switch_view.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/widgets/batch_card.dart';
import 'package:school_of_future/features/presentation/quiz/quiz_create/bloc/create_quiz_bloc.dart';

class QuizCreateScreen extends StatelessWidget {
  const QuizCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateQuizBloc>();
    final titleFocusnode = FocusNode();
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final durationFocusnode = FocusNode();
    final passPercentageFocusnode = FocusNode();
    final graceTimeFocusnode = FocusNode();

    final titleController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final durationController = TextEditingController();
    final passPercentageController = TextEditingController();
    final graceTimeController = TextEditingController();

    MultiValueDropDownController cntMulti = MultiValueDropDownController();

    return BlocBuilder<CreateQuizBloc, CreateQuizState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.quizDtls.data != null &&
              state.quizDtls.data!.assignStudents!.isNotEmpty) {
            final data = state.quizDtls.data!;

            List<int> batchIds = [];
            List<DropDownValueModel> modalData = [];

            for (int i = 0; i < data.sections!.length; i++) {
              batchIds.add(data.sections![i].id!);
            }

            for (int i = 0; i < state.sectionList.length; i++) {
              if (batchIds.contains(state.sectionList[i].value)) {
                modalData.add(DropDownValueModel(
                    name: state.sectionList[i].name,
                    value: state.sectionList[i].value));
              }
            }
            cntMulti = MultiValueDropDownController(
              data: modalData,
            );

            bloc.add(SelectSectionList(sectionList: modalData));
          } else if (state.quizDtls.data == null && state.quizId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.createQuiz.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        titleController.text = state.title;
        startDateController.text = state.startDate;
        endDateController.text = state.endDate;
        durationController.text = state.duration;
        passPercentageController.text = state.passPercentage;
        graceTimeController.text = state.graceTime;
        // cntMulti.dropDownValueList = state.sectionList;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.createQuiz.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.title.tr(),
                      hintText: LocaleKeys.enterTitle.tr(),
                      borderColor: bGray12,
                      focusNode: titleFocusnode,
                      controller: titleController,
                      onChanged: (String value) {
                        bloc.add(ChangeTitle(title: value));
                      },
                      errorText:
                          state.forms == Forms.invalid && state.title.isEmpty
                              ? LocaleKeys.enterTitle.tr()
                              : '',
                    ),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.startDate.tr(),
                      hintText: LocaleKeys.selectStartDate.tr(),
                      borderColor: bGray12,
                      focusNode: startDateFocusnode,
                      controller: startDateController,
                      isReadOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month,
                          size: 30, color: bGray32),
                      onChanged: (String value) {},
                      onTouch: () async {
                        startDateController.text =
                            await showDateTimePickerDialog(context,
                                    initialdate: state.startDate) ??
                                '';
                        bloc.add(
                            StartDate(startDate: startDateController.text));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.startDate.isEmpty
                          ? LocaleKeys.selectStartDate.tr()
                          : '',
                    ),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.endDate.tr(),
                      hintText: LocaleKeys.selectEndDate.tr(),
                      borderColor: bGray12,
                      focusNode: endDateFocusnode,
                      controller: endDateController,
                      isReadOnly: true,
                      suffixIcon: const Icon(Icons.calendar_month,
                          size: 30, color: bGray32),
                      onChanged: (String value) {},
                      onTouch: () async {
                        endDateController.text = await showDateTimePickerDialog(
                                context,
                                initialdate: state.endDate) ??
                            '';
                        bloc.add(EndDate(endDate: endDateController.text));
                      },
                      errorText:
                          state.forms == Forms.invalid && state.endDate.isEmpty
                              ? LocaleKeys.selectEndDate.tr()
                              : '',
                    ),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      textInputType: TextInputType.number,
                      fieldTitle:
                          "${LocaleKeys.duration.tr()} (${LocaleKeys.min.tr()})",
                      hintText: LocaleKeys.enterDuration.tr(),
                      borderColor: bGray12,
                      focusNode: durationFocusnode,
                      controller: durationController,
                      onChanged: (String value) {
                        bloc.add(ChangeDuration(duration: value));
                      },
                      errorText:
                          state.forms == Forms.invalid && state.duration.isEmpty
                              ? LocaleKeys.enterDuration.tr()
                              : '',
                    ),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      textInputType: TextInputType.number,
                      fieldTitle: LocaleKeys.passPer.tr(),
                      hintText: LocaleKeys.enterPassPer.tr(),
                      borderColor: bGray12,
                      focusNode: passPercentageFocusnode,
                      controller: passPercentageController,
                      onChanged: (String value) {
                        bloc.add(ChangePassPercentage(passPercentage: value));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.passPercentage.isEmpty
                          ? LocaleKeys.enterPassPer.tr()
                          : '',
                    ),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      textInputType: TextInputType.number,
                      fieldTitle: LocaleKeys.graceTime.tr(),
                      hintText: LocaleKeys.enterGraceTime.tr(),
                      borderColor: bGray12,
                      focusNode: graceTimeFocusnode,
                      controller: graceTimeController,
                      onChanged: (String value) {
                        bloc.add(ChangeGraceTime(graceTime: value));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.graceTime.isEmpty
                          ? LocaleKeys.enterGraceTime.tr()
                          : '',
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.isCommon.tr(),
                          textStyle: bBody1,
                        ),
                        SwitchView(
                          defaultValue: state.isCommon,
                          onChanged: (bool value) {
                            bloc.add(IsCommon(common: value));
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.allowLateSub.tr(),
                          textStyle: bBody1,
                        ),
                        SwitchView(
                          defaultValue: state.allowLateSub,
                          onChanged: (bool value) {
                            bloc.add(AllowLateSub(isLateSub: value));
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.isMarkEditable.tr(),
                          textStyle: bBody1,
                        ),
                        SwitchView(
                          defaultValue: state.isMarkEditable,
                          onChanged: (bool value) {
                            bloc.add(IsMarkEditable(isMarkEditable: value));
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.allowRetake.tr(),
                          textStyle: bBody1,
                        ),
                        SwitchView(
                          defaultValue: state.allowRetake,
                          onChanged: (bool value) {
                            bloc.add(AllowRetake(allowRetake: value));
                          },
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
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.subject.tr(),
                      labelColor: bBlack,
                      setState: state.setSubject,
                      dropDownValue: state.selectedSubjectId,
                      selected: (dynamic type) {
                        bloc.add(SelectSubjectId(id: type));
                        cntMulti.clearDropDown();
                      },
                      items: state.subjectList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedSubjectId == -1)
                      TextB(text: LocaleKeys.subject.tr(), fontColor: bRed),

                    //==============Section================

                    if (!state.isCommon)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          TextB(
                              text: LocaleKeys.section.tr(), textStyle: bBody1),
                          SizedBox(
                            height: 50,
                            child: DropDownTextField.multiSelection(
                              dropDownIconProperty: IconProperty(
                                icon: Icons.keyboard_arrow_down,
                                color: bGray,
                              ),
                              textFieldDecoration: InputDecoration(
                                  hintText: "Select",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: bGray,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 20,
                                  ),
                                  fillColor: bWhite,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: bGray12),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: bGray12),
                                    borderRadius: BorderRadius.circular(7),
                                  )),
                              controller: cntMulti,
                              displayCompleteItem: true,
                              clearOption: false,
                              checkBoxProperty:
                                  CheckBoxProperty(activeColor: bPrimaryColor),
                              dropDownList: state.sectionList,
                              onChanged: (list) {
                                bloc.add(SelectSectionList(sectionList: list));
                              },
                            ),
                          ),
                          if (state.forms == Forms.invalid &&
                              state.assignToBatchId.isEmpty)
                            TextB(
                                text: LocaleKeys.section.tr(), fontColor: bRed),

                          //==============Batch================
                          const Gap(10),
                          if (state.batchWiseStudent.isNotEmpty &&
                              !state.batchLoading)
                            BachCard(
                              assignToBatchId: state.assignToBatchId,
                              selectedBatchName: state.selectedBatchName,
                              selecteClassName: state.selecteClassName,
                              listOfCheckUncheckStudent:
                                  state.listOfCheckUncheckStudent,
                              press: (int index) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(selectedStudentsScreen,
                                        arguments: state
                                            .listOfCheckUncheckStudent[index])
                                    .then((value) {
                                  if (value != null) {
                                    final backWithUnselected =
                                        value as List<CheckUncheckStudents>;

                                    bloc.add(BackWithUnselected(
                                        students: backWithUnselected,
                                        index: index));
                                  }
                                });
                              },
                            ),
                          if (state.batchLoading)
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),

                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.quesLevel.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectLevelId,
                      selected: (dynamic type) {
                        bloc.add(SelectLeevelId(id: type));
                      },
                      items: state.questionLevel,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectLevelId == -1)
                      TextB(text: LocaleKeys.quesLevel.tr(), fontColor: bRed),
                    const Gap(30),
                    ButtonB(
                      heigh: 60,
                      bgColor: kSecondaryColor,
                      text: state.selectedQstns.isEmpty
                          ? LocaleKeys.addQuestions.tr()
                          : "${LocaleKeys.question.tr()}: ${state.selectedQstns.length}, ${LocaleKeys.marks.tr()}: ${state.fullMarks}",
                      press: () {
                        if (state.selectedSubjectId == -1) {
                          bloc.add(CheckSubjectId(id: state.selectedSubjectId));
                        } else {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(addQuestionPScreen, arguments: {
                            "selectedQstns": state.selectedQstns,
                            "subject_id": state.selectedSubjectId
                          }).then((value) {
                            if (value != null) {
                              final selectedQuestions =
                                  value as List<TempQuestion>;

                              bloc.add(
                                  SelectedQuestions(qst: selectedQuestions));
                            }
                          });
                        }
                      },
                    ),
                    const Gap(20),
                    ButtonB(
                      heigh: 60,
                      text: state.quizId == -1
                          ? LocaleKeys.create.tr()
                          : LocaleKeys.save.tr(),
                      press: () {
                        bloc.add(
                          PressToCreate(
                            isDraft: false,
                            titleFocusnode: titleFocusnode,
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
