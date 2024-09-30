import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
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
  });
  final VoidCallback pressFilterBtn;
  final bool showStartDate,
      showEndDate,
      showVersion,
      showClass,
      showSubject,
      showSection,
      showChapter,
      showSubjectForStudent;

  @override
  Widget build(BuildContext context) {
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    return BlocBuilder<FilterSidebarBloc, FilterSidebarState>(
      builder: (context, state) {
        final bloc = context.read<FilterSidebarBloc>();
        return Column(
          children: [
            const Gap(30),
            //=============Start date===========
            if (showStartDate)
              Column(
                children: [
                  const Gap(30),
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
                ],
              ),
            //=============End date=============
            if (showEndDate)
              Column(
                children: [
                  const Gap(30),
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
                ],
              ),
            //=============Version==============
            if (showVersion)
              Column(
                children: [
                  const Gap(30),
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
                ],
              ),
            //=============Class================
            if (showClass)
              Column(
                children: [
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
                ],
              ),
            //=============Subject==============
            if (showSubject)
              Column(
                children: [
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
                ],
              ),
            //=======Subject for student========
            if (showSubjectForStudent)
              Column(
                children: [
                  const Gap(10),
                  DropdownFieldB(
                    dropdownHeight: 50,
                    label: LocaleKeys.subject.tr(),
                    setState: state.setChapter,
                    labelColor: bBlack,
                    dropDownValue: state.selectSubjectIdForStudent,
                    selected: (dynamic type) {
                      print(type);
                      bloc.add(SelectSubjectIdForStudent(id: type));
                    },
                    items: state.studentSubjectList,
                  ),
                ],
              ),
            //=============Section==============
            if (showSection)
              Column(
                children: [
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
                ],
              ),
            //=============Chapter==============
            if (showChapter)
              Column(
                children: [
                  const Gap(10),
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
                ],
              ),
            const Gap(30),
            //===========Filter Button==========
            ButtonB(
              heigh: 60,
              text: LocaleKeys.filter.tr(),
              press: () {
                Navigator.pop(context);
                pressFilterBtn();
              },
            ),
            const Gap(70),
          ],
        );
      },
    );
  }
}
