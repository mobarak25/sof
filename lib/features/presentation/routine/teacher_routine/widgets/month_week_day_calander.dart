import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/routine/teacher_routine/widgets/month_calander.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthWeekDayCalendar extends StatefulWidget {
  const MonthWeekDayCalendar({
    super.key,
    required this.onDateChanged,
    this.isTodayIsLastDay = false,
  });

  final Function(DateTime) onDateChanged;
  final bool isTodayIsLastDay;

  @override
  MonthWeekDayCalendarState createState() => MonthWeekDayCalendarState();
}

class MonthWeekDayCalendarState extends State<MonthWeekDayCalendar> {
  var currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bWhite,
      child: Column(
        children: [
          AppMonthChanger(
            canGoToFutureMonth: !widget.isTodayIsLastDay,
            getMonthChange: (date) {
              setState(() {
                widget.onDateChanged(date);
                currentDate = date;
              });
            },
            selectedDay: currentDate,
          ),
          Container(height: 1, width: double.infinity, color: bGray4),
          Container(
            color: kWhiteColor,
            height: 100,
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: widget.isTodayIsLastDay
                  ? DateTime.now()
                  : DateTime.utc(2030, 3, 14),
              daysOfWeekVisible: false,
              shouldFillViewport: true,
              focusedDay: currentDate,
              currentDay: currentDate,
              selectedDayPredicate: (day) => isSameDay(currentDate, day),
              calendarFormat: CalendarFormat.week,
              onPageChanged: (dateTime) {
                setState(() {
                  widget.onDateChanged(dateTime);
                  currentDate = dateTime;
                });
              },
              headerVisible: false,
              onDaySelected: (selectedDate, focusDate) {
                setState(() {
                  widget.onDateChanged(selectedDate);
                  currentDate = selectedDate;
                });
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, daySecond) {
                  return Stack(
                    children: [
                      Container(
                        width: 56,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xff37BFD7), Color(0xff17799C)],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextB(
                              text: DateFormat('EEE').format(date),
                              textStyle: bBase2,
                              fontColor: bWhite,
                            ),
                            TextB(
                              text: DateFormat('d').format(date),
                              textStyle: bHead6M.copyWith(fontSize: 18),
                              fontColor: bWhite,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: kPrimaryColor,
                          width: double.infinity,
                          height: 6,
                        ),
                      ),
                    ],
                  );
                },
                defaultBuilder: (context, date1, date2) {
                  return UnselectedDayWidget(
                    date: date1,
                  );
                },
                disabledBuilder: (context, date1, date2) {
                  return UnselectedDayWidget(
                    date: date1,
                  );
                },
                outsideBuilder: (context, date1, date2) {
                  return UnselectedDayWidget(
                    date: date1,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UnselectedDayWidget extends StatelessWidget {
  const UnselectedDayWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextB(
            text: DateFormat('EEE').format(date),
            textStyle: bBase2,
            fontColor: bGray32,
          ),
          TextB(
            text: DateFormat('d').format(date),
            textStyle: bHead6M.copyWith(fontSize: 18),
            fontColor: bGray52,
          ),
        ],
      ),
    );
  }
}
