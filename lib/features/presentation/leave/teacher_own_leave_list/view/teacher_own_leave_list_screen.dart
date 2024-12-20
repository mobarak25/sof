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
import 'package:school_of_future/core/widgets/floating_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

import 'package:school_of_future/features/presentation/leave/teacher_own_leave_list/bloc/teacher_own_leave_bloc.dart';
import 'package:school_of_future/features/presentation/leave/teacher_own_leave_list/widgets/leave_item.dart';

class TeacherOwnLeaveListScreen extends StatelessWidget {
  const TeacherOwnLeaveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();

    final scroll = ScrollController();

    return BlocBuilder<TeacherOwnLeaveBloc, TeacherOwnLeaveState>(
      builder: (context, state) {
        final bloc = context.read<TeacherOwnLeaveBloc>();

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: context.tr(LocaleKeys.leaveList),
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
                  Column(
                    children: [
                      const Gap(50),
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
                      ),
                      const Gap(20),
                    ],
                  ),
                  //=============End date=============

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
                                  endController: endDateController,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const Gap(30),
                      ButtonB(
                        heigh: 60,
                        text: LocaleKeys.filter.tr(),
                        press: () {
                          bloc.add(PressFilter());
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
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
                    context.tr(LocaleKeys.pending),
                    context.tr(LocaleKeys.accepted),
                    context.tr(LocaleKeys.rejected),
                  ],
                  onTabChanged: (int tabIndex) {
                    bloc.add(DataForTab(tabIndex: tabIndex.toString()));
                  },
                  search: (String value) {
                    bloc.add(ChangeSearch(searchText: value));
                  },
                  child: state.leaveList.data != null
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: scroll,
                                children: [
                                  ...List.generate(
                                    state.leaveList.data!.length,
                                    (position) {
                                      final dataItem =
                                          state.leaveList.data![position];
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          LeaveItemView(
                                            data: dataItem,
                                            press: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pushNamed(
                                                teacherLeaveDetailsScreen,
                                                arguments: dataItem.id,
                                              );
                                            },
                                            prssToEditDel:
                                                (String pressTo, int id) {
                                              bloc.add(PressToDelEdit(
                                                  type: pressTo, id: id));
                                            },
                                          ),
                                          const Gap(15),
                                        ],
                                      );
                                    },
                                  ),
                                  if (state.leaveList.data!.isEmpty)
                                    TextB(
                                      text:
                                          context.tr(LocaleKeys.noResultFound),
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
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(teacherOwnApplyLeaveScreen, arguments: -1);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
