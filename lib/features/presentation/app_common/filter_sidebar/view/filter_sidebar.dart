import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

class FilterSidebar extends StatelessWidget {
  const FilterSidebar({
    super.key,
    required this.pressFilterBtn,
    this.showStartDate = false,
    this.showEndDate = false,
    this.showVersion = false,
    this.showClass = false,
    this.showSubject = false,
    this.showSection = false,
    this.showChapter = false,
    this.showSubjectForStudent = false,
    this.canPop = true,
    this.paddingTop = 30,
    this.checkValidation = false,
    required this.btnText,
  });
  final VoidCallback pressFilterBtn;
  final bool showStartDate,
      showEndDate,
      showVersion,
      showClass,
      showSubject,
      showSection,
      showChapter,
      showSubjectForStudent,
      canPop,
      checkValidation;
  final double paddingTop;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    return BlocBuilder<FilterSidebarBloc, FilterSidebarState>(
      builder: (context, state) {
        final bloc = context.read<FilterSidebarBloc>();
        return Container(
          padding: EdgeInsets.only(top: paddingTop),
          child: Column(
            children: [
              //=============Start date===========
              if (showStartDate)
                Column(
                  children: [
                    TextFieldB(
                      fieldTitle: LocaleKeys.startDate.tr(),
                      hintText: LocaleKeys.selectStartDate.tr(),
                      focusNode: startDateFocusnode,
                      controller: startDateController,
                      borderColor: bGray12,
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: bGray32,
                      ),
                      isReadOnly: true,
                      onChanged: () {},
                      onTouch: () {
                        datePicker(
                          context,
                          date: (DateTime date) {
                            bloc.add(
                              SelectStartDate(
                                startDate: date,
                                startController: startDateController,
                              ),
                            );
                          },
                        );
                      },
                      // errorText:
                      //     state.forms == Forms.invalid && state.dateFrom.isEmpty
                      //         ? 'Select date from'
                      //         : '',
                    ),
                    const Gap(20),
                  ],
                ),
              //=============End date=============
              if (showEndDate)
                Column(
                  children: [
                    TextFieldB(
                      fieldTitle: LocaleKeys.endDate.tr(),
                      hintText: LocaleKeys.selectEndDate.tr(),
                      focusNode: endDateFocusnode,
                      controller: endDateController,
                      borderColor: bGray12,
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: bGray32,
                      ),
                      isReadOnly: true,
                      onChanged: () {},
                      onTouch: () {
                        datePicker(
                          context,
                          date: (DateTime date) {
                            bloc.add(
                              SelectEndDate(
                                endDate: date,
                                endDateController: endDateController,
                              ),
                            );
                          },
                        );
                      },
                      // errorText:
                      //     state.forms == Forms.invalid && state.dateFrom.isEmpty
                      //         ? 'Select date from'
                      //         : '',
                    ),
                    const Gap(30),
                  ],
                ),
              //=============Version==============
              if (showVersion)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        textStyle: bBase2,
                        fontColor: bRed,
                      ),
                    const Gap(10),
                  ],
                ),
              //=============Class================
              if (showClass)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        textStyle: bBase2,
                        fontColor: bRed,
                      ),
                    const Gap(10),
                  ],
                ),
              //=============Subject==============
              if (showSubject)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        text: LocaleKeys.plsSelectSubject.tr(),
                        textStyle: bBase2,
                        fontColor: bRed,
                      ),
                    const Gap(10),
                  ],
                ),
              //=======Subject for student========
              if (showSubjectForStudent)
                Column(
                  children: [
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.subject.tr(),
                      setState: state.setChapter,
                      labelColor: bBlack,
                      dropDownValue: state.selectSubjectIdForStudent,
                      selected: (dynamic type) {
                        bloc.add(SelectSubjectIdForStudent(id: type));
                      },
                      items: state.studentSubjectList,
                    ),
                    const Gap(10),
                  ],
                ),
              //=============Section==============
              if (showSection)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        textStyle: bBase2,
                        fontColor: bRed,
                      ),
                    const Gap(10),
                  ],
                ),
              //=============Chapter==============
              if (showChapter)
                Column(
                  children: [
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.chapter.tr(),
                      labelColor: bBlack,
                      setState: state.setChapter,
                      dropDownValue: state.selectChapterId,
                      selected: (dynamic type) {
                        bloc.add(SelectChapterId(id: type));
                      },
                      items: state.chapterList,
                    ),
                    const Gap(10),
                  ],
                ),
              const Gap(20),
              //===========Filter Button==========
              ButtonB(
                heigh: 60,
                text: btnText,
                press: () {
                  if (checkValidation) {
                    bloc.add(CheckValidation());
                  }
                  if (checkValidation && state.isValid) {
                    pressFilterBtn();
                  }

                  if (!checkValidation) {
                    print("no valid");
                    pressFilterBtn();
                  }

                  if (canPop) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
