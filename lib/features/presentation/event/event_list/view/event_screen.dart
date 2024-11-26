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
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/features/presentation/event/event_list/bloc/event_bloc.dart';
import 'package:school_of_future/features/presentation/event/event_list/widgets/event_card.dart';
import 'package:school_of_future/features/presentation/event/event_list/widgets/event_month_calendar.dart';

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
            title: context.tr(LocaleKeys.academicCalendar),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: CustomTab(
              loading: false,
              showSearch: false,
              tabList: [
                context.tr(LocaleKeys.listView),
                context.tr(LocaleKeys.calendarView),
              ],
              onTabChanged: (int tabIndex) {
                bloc.add(DataForTab(tabIndex: tabIndex.toString()));
              },
              search: (String value) {},
              child: state.eventList.data != null
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView(
                            controller: scroll,
                            children: [
                              if (state.activeTab == "0")
                                AppMonthChanger(
                                  canGoToFutureMonth: true,
                                  getMonthChange: (date) {
                                    bloc.add(ChangeDate(date: date));
                                  },
                                  selectedDay: utcDateTime(state.startDate),
                                ),
                              if (state.activeTab == "1")
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      decoration: const BoxDecoration(
                                        color: bWhite,
                                      ),
                                      child: EventMonthCalendar(
                                        isLoading: false,
                                        events: state.events,
                                        activeDate:
                                            utcDateTime(state.startDate),
                                        onMonthChanged: (date) {
                                          bloc.add(ChangeDate(date: date));
                                        },
                                        onDateChanged: (date) {
                                          bloc.add(ChangeDay(date: date));
                                        },
                                      ),
                                    ),
                                    const Gap(20),
                                  ],
                                ),
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
                                          eventDetailsScreen,
                                          arguments: dataItem.id,
                                        );
                                      },
                                      child: EventCard(
                                        item: dataItem,
                                      ),
                                    ),
                                    const Gap(15),
                                  ],
                                );
                              }),
                              if (state.eventList.data!.isEmpty)
                                TextB(
                                  text: context.tr(LocaleKeys.noResultFound),
                                  textStyle: bBody1B,
                                  fontColor: bRed,
                                  alignMent: TextAlign.center,
                                ),
                              if (!state.incrementLoader && state.isEndList)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 30),
                                  child: TextB(
                                    text: context.tr(LocaleKeys.endOfTheList),
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
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        );
      },
    );
  }

  DateTime utcDateTime(String date) {
    List<String> parts = date.split("-");

    DateTime dateTime = DateTime.utc(
      int.parse(parts[0]), // year
      int.parse(parts[1]), // month
      int.parse(parts[2]), // day
    );

    return dateTime;
  }
}
