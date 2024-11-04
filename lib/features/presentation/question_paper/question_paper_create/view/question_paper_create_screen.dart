import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
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
import 'package:school_of_future/features/presentation/question_paper/question_paper_create/bloc/question_paper_create_bloc.dart';

class QuestionPaperCreateScreen extends StatelessWidget {
  const QuestionPaperCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QuestionPaperCreateBloc>();
    final titleFocusnode = FocusNode();
    final startDateFocusnode = FocusNode();
    final typeFocusnode = FocusNode();
    final durationFocusnode = FocusNode();

    final titleController = TextEditingController();
    final startDateController = TextEditingController();
    final typeController = TextEditingController();
    final durationController = TextEditingController();

    return BlocBuilder<QuestionPaperCreateBloc, QuestionPaperCreateState>(
      builder: (context, state) {
        titleController.text = state.title;
        startDateController.text = state.startDate;
        typeController.text = state.paperType;
        durationController.text = state.duration;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.createQuestionPaper.tr(),
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
                            fieldTitle: LocaleKeys.title.tr(),
                            hintText: LocaleKeys.enterTitle.tr(),
                            borderColor: bGray12,
                            focusNode: titleFocusnode,
                            controller: titleController,
                            onChanged: (String value) {
                              bloc.add(ChangeTitle(title: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.title.isEmpty
                                ? LocaleKeys.enterTitle.tr()
                                : '',
                          ),
                          const Gap(10),
                          TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.date.tr(),
                            hintText: "yyyy-mm-dd",
                            textInputType: TextInputType.number,
                            borderColor: bGray12,
                            focusNode: startDateFocusnode,
                            controller: startDateController,
                            isReadOnly: true,
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              size: 30,
                              color: bGray32,
                            ),
                            onChanged: (String value) {},
                            onTouch: () async {
                              startDateController.text =
                                  await showDateTimePickerDialog(context,
                                          initialdate: state.startDate) ??
                                      '';
                              bloc.add(StartDate(
                                  startDate: startDateController.text));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.startDate.isEmpty
                                ? LocaleKeys.selectStartDate.tr()
                                : '',
                          ),
                          const Gap(10),
                          TextFieldB(
                            fieldTitle: LocaleKeys.type.tr(),
                            hintText: LocaleKeys.enterType.tr(),
                            borderColor: bGray12,
                            focusNode: typeFocusnode,
                            controller: typeController,
                            onChanged: (String value) {
                              bloc.add(ChangeType(type: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.paperType.isEmpty
                                ? LocaleKeys.enterTitle.tr()
                                : '',
                          ),
                          const Gap(10),
                          TextFieldB(
                            fieldTitle: LocaleKeys.duration.tr(),
                            hintText: LocaleKeys.enterDuration.tr(),
                            borderColor: bGray12,
                            focusNode: durationFocusnode,
                            controller: durationController,
                            onChanged: (String value) {
                              bloc.add(ChangeDuration(duration: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.duration.isEmpty
                                ? LocaleKeys.enterDuration.tr()
                                : '',
                          ),
                          const Gap(20),
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
                          const Gap(20),
                          ButtonB(
                            heigh: 60,
                            bgColor: kSecondaryColor,
                            text: state.selectedQstns.isEmpty
                                ? LocaleKeys.addQuestions.tr()
                                : "${LocaleKeys.question.tr()}: ${state.selectedQstns.length}, ${LocaleKeys.marks.tr()}: ${state.fullMarks}",
                            press: () {
                              if (state.selectedSubjectId == -1) {
                                bloc.add(CheckSubjectId(
                                    id: state.selectedSubjectId));
                              } else {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(addQuestionPScreen, arguments: {
                                  "selectedQstns": state.selectedQstns,
                                  "subject_id": state.selectedSubjectId
                                }).then((value) {
                                  if (value != null) {
                                    final selectedQuestions =
                                        value as List<TempQuestion>;

                                    bloc.add(SelectedQuestions(
                                        qst: selectedQuestions));
                                  }
                                });
                              }
                            },
                          ),
                          const Gap(20),
                          ButtonB(
                            heigh: 60,
                            text: state.qPaperId == -1
                                ? LocaleKeys.create.tr()
                                : LocaleKeys.save.tr(),
                            press: () {
                              bloc.add(
                                PressToCreate(
                                  isDraft: false,
                                  titleFocusnode: titleFocusnode,
                                  startDateFocusnode: startDateFocusnode,
                                  typeFocusnode: typeFocusnode,
                                  durationFocusnode: durationFocusnode,
                                ),
                              );
                            },
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
