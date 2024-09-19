import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/floating_button.dart';

class ClassworkListScreen extends StatelessWidget {
  const ClassworkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Body(
      isFullScreen: true,
      appBar: FutureAppBar(
        actions: const [SizedBox()],
        title: LocaleKeys.classwork.tr(),
      ),

      // drawerChild: Padding(
      //   padding: EdgeInsets.only(
      //     top: MediaQuery.of(context).padding.top,
      //     bottom: MediaQuery.of(context).padding.bottom,
      //     left: 10,
      //     right: 10,
      //   ),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         const Gap(30),
      //         TextFieldB(
      //           fieldTitle: LocaleKeys.startDate.tr(),
      //           hintText: LocaleKeys.selectStartDate.tr(),
      //           focusNode: startDateFocusnode,
      //           controller: startDateController,
      //           borderColor: bGray12,
      //           suffixIcon: const Icon(
      //             Icons.calendar_month,
      //             size: 30,
      //             color: bGray32,
      //           ),
      //           isReadOnly: true,
      //           onChanged: () {},
      //           onTouch: () {
      //             datePicker(
      //               context,
      //               date: (DateTime date) {
      //                 bloc.add(
      //                   SelectStartDate(
      //                     startDate: date,
      //                     startController: startDateController,
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //           // errorText:
      //           //     state.forms == Forms.invalid && state.dateFrom.isEmpty
      //           //         ? 'Select date from'
      //           //         : '',
      //         ),
      //         const Gap(30),
      //         TextFieldB(
      //           fieldTitle: LocaleKeys.endDate.tr(),
      //           hintText: LocaleKeys.selectEndDate.tr(),
      //           focusNode: endDateFocusnode,
      //           controller: endDateController,
      //           borderColor: bGray12,
      //           suffixIcon: const Icon(
      //             Icons.calendar_month,
      //             size: 30,
      //             color: bGray32,
      //           ),
      //           isReadOnly: true,
      //           onChanged: () {},
      //           onTouch: () {
      //             datePicker(
      //               context,
      //               date: (DateTime date) {
      //                 bloc.add(
      //                   SelectEndDate(
      //                     endDate: date,
      //                     endDateController: endDateController,
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //           // errorText:
      //           //     state.forms == Forms.invalid && state.dateFrom.isEmpty
      //           //         ? 'Select date from'
      //           //         : '',
      //         ),
      //         const Gap(30),
      //         DropdownFieldB(
      //           dropdownHeight: 50,
      //           label: LocaleKeys.version.tr(),
      //           labelColor: bBlack,
      //           dropDownValue: state.selectedVersionId,
      //           selected: (dynamic type) {
      //             bloc.add(SelectVersionId(id: type));
      //           },
      //           items: state.versionList,
      //         ),
      //         const Gap(10),
      //         DropdownFieldB(
      //           dropdownHeight: 50,
      //           setState: state.setClass,
      //           label: LocaleKeys.classStr.tr(),
      //           labelColor: bBlack,
      //           dropDownValue: state.selectedClassId,
      //           selected: (dynamic type) {
      //             bloc.add(SelectClassId(id: type));
      //           },
      //           items: state.classList,
      //         ),
      //         const Gap(10),
      //         DropdownFieldB(
      //           dropdownHeight: 50,
      //           label: LocaleKeys.subject.tr(),
      //           labelColor: bBlack,
      //           setState: state.setSubject,
      //           dropDownValue: state.selectedSubjectId,
      //           selected: (dynamic type) {
      //             bloc.add(SelectSubjectId(id: type));
      //           },
      //           items: state.subjectList,
      //         ),
      //         const Gap(10),
      //         DropdownFieldB(
      //           dropdownHeight: 50,
      //           label: LocaleKeys.section.tr(),
      //           labelColor: bBlack,
      //           setState: state.setSection,
      //           dropDownValue: state.selectSectionId,
      //           selected: (dynamic type) {
      //             bloc.add(SelectSectionId(id: type));
      //           },
      //           items: state.sectionList,
      //         ),
      //         const Gap(30),
      //         ButtonB(
      //           heigh: 60,
      //           text: LocaleKeys.filter.tr(),
      //           press: () {
      //             Navigator.pop(context);
      //             bloc.add(PressFilter());
      //           },
      //         ),
      //         const Gap(70),
      //       ],
      //     ),
      //   ),
      // ),

      child: Stack(
        children: [
          FloatingButton(
            press: () {
              // Navigator.pushNamed(navigatorKey.currentState!.context,
              //     teacherAssignmentCreateScreen);

              Navigator.of(context, rootNavigator: true)
                  .pushNamed(teacherClassworkCreateSreen, arguments: -1);
            },
          )
        ],
      ),
    );
  }
}
