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
import 'package:school_of_future/core/widgets/floating_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/view/filter_sidebar.dart';
import 'package:school_of_future/features/presentation/meeting/teacher_meeting_list/bloc/theacher_meeting_list_bloc.dart';
import 'package:school_of_future/features/presentation/meeting/teacher_meeting_list/widgets/meeting_card.dart';

class TeacherMeetingListScreen extends StatelessWidget {
  const TeacherMeetingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<TheacherMeetingListBloc, TheacherMeetingListState>(
      builder: (context, state) {
        final bloc = context.read<TheacherMeetingListBloc>();
        final filterBloc = context.read<FilterSidebarBloc>();

        if (state.isFirst) {
          bloc.add(
              DataForTab(tabIndex: state.activeTab, filterBloc: filterBloc));
        }

        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement(filterBloc: filterBloc));
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.meeting.tr(),
          ),
          drawerChild: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: FilterSidebar(
                showStartDate: true,
                showEndDate: true,
                pressFilterBtn: () {
                  bloc.add(PressFilter(filterBloc: filterBloc));
                },
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
                    LocaleKeys.guardian.tr(),
                    LocaleKeys.admin.tr(),
                  ],
                  onTabChanged: (int tabIndex) {
                    bloc.add(DataForTab(
                        tabIndex: tabIndex.toString(), filterBloc: filterBloc));
                  },
                  search: (String value) {
                    bloc.add(ChangeSearch(
                        searchText: value, filterBloc: filterBloc));
                  },
                  child: state.meetingList.data != null
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: scroll,
                                children: [
                                  ...List.generate(
                                      state.meetingList.data!.length,
                                      (position) {
                                    final dataItem =
                                        state.meetingList.data![position];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pushNamed(
                                              meetingDetailsScreen,
                                              arguments: dataItem.id,
                                            );
                                          },
                                          child: MeetingCard(
                                            item: dataItem,
                                            isTeacher: state.isTeacher,
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
                                  if (state.meetingList.data!.isEmpty)
                                    TextB(
                                      text: LocaleKeys.noResultFound.tr(),
                                      textStyle: bBody1B,
                                      fontColor: bRed,
                                      alignMent: TextAlign.center,
                                    ),
                                  if (!state.incrementLoader && state.isEndList)
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 30),
                                      child: TextB(
                                        text: "End of the list",
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
              if (state.isTeacher)
                FloatingButton(
                  press: () {
                    // Navigator.pushNamed(navigatorKey.currentState!.context,
                    //     teacherAssignmentCreateScreen);

                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(teacherMeetingCreateScreen, arguments: -1);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
