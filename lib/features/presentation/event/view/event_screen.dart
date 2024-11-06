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
import 'package:school_of_future/core/widgets/month_calander.dart';
import 'package:school_of_future/core/widgets/month_week_day_calander.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/event/bloc/event_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        final bloc = context.read<EventBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.academicCalendar.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: CustomTab(
              loading: state.loading,
              showSearch: false,
              tabList: [
                LocaleKeys.listView.tr(),
                LocaleKeys.calendarView.tr(),
              ],
              onTabChanged: (int tabIndex) {
                bloc.add(DataForTab(tabIndex: tabIndex.toString()));
              },
              search: (String value) {},
              child: state.eventList.data != null
                  ? Column(
                      children: [
                        AppMonthChanger(
                          canGoToFutureMonth: true,
                          getMonthChange: (date) {
                            print(date);
                          },
                          //  selectedDay: currentDate,
                        ),
                        Expanded(
                          child: ListView(
                            controller: scroll,
                            children: [
                              ...List.generate(state.eventList.data!.length,
                                  (position) {
                                final dataItem =
                                    state.eventList.data![position];
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
                                      child: const TextB(text: "text"),

                                      //  MeetingCard(
                                      //   item: dataItem,
                                      //   isTeacher: state.isTeacher,
                                      //   pressTo: (String pressTo, int id) {
                                      //     bloc.add(PressToDelEdit(
                                      //         type: pressTo, id: id));
                                      //   },
                                      // ),
                                    ),
                                    const Gap(15),
                                  ],
                                );
                              }),
                              if (state.eventList.data!.isEmpty)
                                TextB(
                                  text: LocaleKeys.noResultFound.tr(),
                                  textStyle: bBody1B,
                                  fontColor: bRed,
                                  alignMent: TextAlign.center,
                                ),
                              if (!state.incrementLoader && state.isEndList)
                                const Padding(
                                  padding: EdgeInsets.only(top: 15, bottom: 30),
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
        );
      },
    );
  }
}
