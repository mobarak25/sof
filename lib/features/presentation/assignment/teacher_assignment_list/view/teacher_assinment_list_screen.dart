import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/floating_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/bloc/teacher_assignment_list_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/widgets/assignment_card.dart';

class TeacherAssinmentListScreen extends StatelessWidget {
  const TeacherAssinmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final scroll = ScrollController();

    return BlocBuilder<TeacherAssignmentListBloc, TeacherAssignmentListState>(
      builder: (context, state) {
        final bloc = context.read<TeacherAssignmentListBloc>();
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.homeWork.tr(),
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
                    },
                    items: state.subjectList,
                  ),
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
                  const Gap(30),
                  ButtonB(
                    heigh: 60,
                    text: LocaleKeys.filter.tr(),
                    press: () {
                      Navigator.pop(context);
                      bloc.add(PressFilter());
                    },
                  ),
                  const Gap(70),
                ],
              ),
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                color: bInnerBg,
                child: CustomTab(
                  loading: state.loading,
                  tabList: [
                    LocaleKeys.published.tr(),
                    LocaleKeys.draft.tr(),
                  ],
                  onTabChanged: (int tabIndex) {
                    bloc.add(DataForTab(tabIndex: tabIndex.toString()));
                  },
                  search: (String value) {
                    bloc.add(ChangeSearch(searchText: value));
                  },
                  child: state.assignmentList.data != null
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: scroll,
                                children: [
                                  ...List.generate(
                                      state.assignmentList.data!.length,
                                      (position) {
                                    final dataItem =
                                        state.assignmentList.data![position];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(
                                              studentAssignmentDetailsScreen,
                                              arguments: dataItem.id,
                                            );
                                          },
                                          child: AssignmentItemCard(
                                            item: dataItem,
                                            pressTo: (String pressTo, int id) {
                                              bloc.add(PressToDelEdit(
                                                  type: pressTo, id: id));
                                            },
                                          ),
                                        ),
                                        const Gap(15),
                                      ],
                                    );
                                  }),
                                  if (state.assignmentList.data!.isEmpty)
                                    TextB(
                                      text: LocaleKeys.noResultFound.tr(),
                                      textStyle: bBody1B,
                                      fontColor: bRed,
                                      alignMent: TextAlign.center,
                                    ),
                                  if (!state.incrementLoader && state.isEndList)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 30),
                                      child: TextB(
                                        text:
                                            context.tr(LocaleKeys.endOfTheList),
                                        textStyle: bBase2M,
                                        fontColor: bRed,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (state.incrementLoader)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            const Gap(65),
                          ],
                        )
                      : const SizedBox(),
                ),
              ),
              FloatingButton(
                press: () {
                  // Navigator.pushNamed(navigatorKey.currentState!.context,
                  //     teacherAssignmentCreateScreen);

                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(teacherAssignmentCreateScreen, arguments: -1);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
