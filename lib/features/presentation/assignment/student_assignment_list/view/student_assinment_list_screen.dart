import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/bloc/student_assignment_list_bloc.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/widgets/assignment_item.dart';

class StudentAssinmentListScreen extends StatelessWidget {
  const StudentAssinmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final scroll = ScrollController();

    return BlocBuilder<StudentAssignmentListBloc, StudentAssignmentListState>(
      builder: (context, state) {
        final bloc = context.read<StudentAssignmentListBloc>();
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: context.tr(LocaleKeys.homeWork),
          ),
          drawerChild: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
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
                  const Gap(30),
                  DropdownFieldB(
                    dropdownHeight: 55,
                    label: LocaleKeys.subject.tr(),
                    labelColor: bBlack,
                    dropDownValue: state.selectedSubId,
                    selected: (dynamic type) {
                      bloc.add(SelectSubjectId(id: type));
                    },
                    items: state.subjectList,
                  ),
                  const Gap(30),
                  ButtonB(
                    heigh: 60,
                    text: LocaleKeys.filter.tr(),
                    press: () {
                      Navigator.pop(context);
                      bloc.add(PressFilter());
                    },
                  )
                ],
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: CustomTab(
              loading: state.loading,
              tabList: [
                context.tr(LocaleKeys.due),
                context.tr(LocaleKeys.submitted),
                context.tr(LocaleKeys.completed),
              ],
              onTabChanged: (int tabIndex) {
                bloc.add(DataForTab(tabIndex: tabIndex.toString()));
              },
              search: (String value) {
                bloc.add(ChangeSearch(searchText: value));
              },
              child: state.assignmentList.data != null
                  ? ListView(
                      controller: scroll,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.assignmentList.data!.length,
                          itemBuilder: (context, position) {
                            final datalist = state.assignmentList.data!;
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                      studentAssignmentDetailsScreen,
                                      arguments: datalist[position].id,
                                    );
                                  },
                                  child: StudentAssignmentItem(
                                    subjectGroupId: datalist[position]
                                        .subject!
                                        .subjectGroup!
                                        .id!,
                                    subjectName:
                                        datalist[position].subject!.name ?? '',
                                    topicName: datalist[position].title ?? '',
                                    dueDate: getDate(
                                        value: datalist[position].dueAt!,
                                        formate: "dd MMM yyyy"),
                                    totalMark:
                                        "${datalist[position].marks}".tr(),
                                    daysLeft:
                                        "${datalist[position].daysLeft}".tr(),
                                    submissionStatus:
                                        datalist[position].submissionStatus,
                                    draftStatus: datalist[position].status == 0,
                                    submissionRequired:
                                        datalist[position].isSubmitable!,
                                  ),
                                ),
                                const Gap(15),
                              ],
                            );
                          },
                        ),
                        if (state.incrementLoader)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 90, top: 10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        if (!state.incrementLoader && state.isEndList)
                          Container(
                            padding: const EdgeInsets.only(bottom: 90, top: 10),
                            child: TextB(
                              text: context.tr(LocaleKeys.endOfTheList),
                              fontColor: bRed,
                              alignMent: TextAlign.center,
                            ),
                          )
                      ],
                    )
                  : const TextB(text: "loading..."),
            ),
          ),
        );
      },
    );
  }
}
