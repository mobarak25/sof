import 'package:flutter/material.dart';

import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/month_calander.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/widgets/calander_highlight.dart';
import 'package:table_calendar/table_calendar.dart';

class EventMonthCalendar extends StatefulWidget {
  const EventMonthCalendar({
    super.key,
    required this.events,
    required this.isLoading,
    required this.onDateChanged,
    required this.onMonthChanged,
    required this.activeDate,
  });

  final bool isLoading;
  final Function onDateChanged;
  final Function onMonthChanged;
  final Map<String, int> events;
  final DateTime activeDate;

  @override
  EventMonthCalendarState createState() => EventMonthCalendarState();
}

class EventMonthCalendarState extends State<EventMonthCalendar> {
  // var currentDate = DateTime.now();

  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.activeDate; // Initialize currentDate in initState
  }

  List<int> _getEventsForDay(DateTime date) {
    final dayNumber = date.day.toString();
    final monthNumber = date.month.toString();
    final dayNumberText = dayNumber.length == 1 ? '0$dayNumber' : dayNumber;
    final monthNumberText =
        monthNumber.length == 1 ? '0$monthNumber' : monthNumber;
    final keyText = '$monthNumberText-$dayNumberText';

    if (widget.events.containsKey(keyText)) {
      return [widget.events[keyText]!];
    }

    return [-1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppMonthChanger(
          getMonthChange: (date) {
            setState(() {
              widget.onDateChanged(date);
              widget.onMonthChanged(date);
              currentDate = date;
            });
          },
          selectedDay: currentDate,
        ),
        widget.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
            : TableCalendar<int>(
                locale: "en",
                daysOfWeekHeight: 30,
                firstDay: DateTime.utc(2010, 10, 16),
                calendarFormat: CalendarFormat.month,
                lastDay: DateTime.utc(2030, 3, 14),
                eventLoader: _getEventsForDay,
                headerVisible: false,
                focusedDay: currentDate,
                currentDay: currentDate,
                selectedDayPredicate: (day) => isSameDay(currentDate, day),
                onPageChanged: (dateTime) {
                  setState(() {
                    widget.onMonthChanged(dateTime);
                    widget.onDateChanged(dateTime);
                    currentDate = dateTime;
                  });
                },
                onDaySelected: (selectedDate, focusDate) {
                  setState(() {
                    widget.onDateChanged(selectedDate);
                    currentDate = selectedDate;
                  });
                },
                holidayPredicate: (date) {
                  if (date.weekday == DateTime.friday) {
                    return true;
                  } else {
                    return false;
                  }
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events[0] == 0) {
                      return CalendarHighlight(
                        bgColor: kAbsentIndicatorColor, //==== absent color
                        day: getDate(value: date.toString(), formate: 'd'),
                      );
                    } else if (events[0] == 1) {
                      return CalendarHighlight(
                        bgColor:
                            const Color(0XFF776AA5), //======= present color
                        day: getDate(value: date.toString(), formate: 'd'),
                        textColor: kWhiteColor,
                      );
                    } else if (events[0] == 2) {
                      return CalendarHighlight(
                        bgColor: kSecondaryColor,
                        day: getDate(value: date.toString(), formate: 'd'),
                      );
                    } else if (events[0] == 3) {
                      return CalendarHighlight(
                        bgColor: kHalfDayIndicatorColor,
                        day: getDate(value: date.toString(), formate: 'd'),
                      );
                    } else {
                      return Container();
                    }
                  },
                  defaultBuilder: (context, day, daySecond) {
                    return CalendarHighlight(
                      textColor: kBlackColor,
                      bgColor: kWhiteColor,
                      day: getDate(value: day.toString(), formate: 'd'),
                    );
                  },
                  outsideBuilder: (context, day, daySecond) {
                    return CalendarHighlight(
                      textColor: kTextDefaultColor.withOpacity(0.5),
                      bgColor: kWhiteColor,
                      day: getDate(value: day.toString(), formate: 'd'),
                    );
                  },
                  holidayBuilder: (context, day, daySecond) {
                    if (day.weekday == DateTime.friday) {
                      return CalendarHighlight(
                        bgColor: kPrimaryColor,
                        day: getDate(value: day.toString(), formate: 'd'),
                      );
                    }
                    return null;
                  },
                  todayBuilder: (context, date1, date2) {
                    return Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              offset: Offset(4, 2),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: Text(
                          getDate(value: date1.toString(), formate: 'd'),
                          style: bBody2.copyWith(color: kPrHoverColor),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, daySecond) {
                    return Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                offset: Offset(4, 2),
                                color: Colors.grey,
                              ),
                            ],
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(3)),
                        alignment: Alignment.center,
                        child: TextB(
                            text: getDate(value: day.toString(), formate: 'd'),
                            textStyle:
                                bBody2.copyWith(color: kTextDefaultColor)),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
