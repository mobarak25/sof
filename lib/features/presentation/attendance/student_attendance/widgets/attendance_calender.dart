import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/widgets/color_indicator.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/widgets/month_report_calander.dart';

class AttendanceCalendarWidget extends StatelessWidget {
  const AttendanceCalendarWidget({
    super.key,
    required this.onDateChanged,
    required this.onMonthChanged,
    required this.loading,
    required this.studentEvents,
  });

  final Function(DateTime) onDateChanged;
  final Function(DateTime) onMonthChanged;
  final bool loading;
  final Map<String, int> studentEvents;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthCalendar(
          onMonthChanged: (date) {
            onMonthChanged(date);
          },
          onDateChanged: (date) {
            onDateChanged(date);
          },
          events: studentEvents,

          // const {
          //   "10-09": 0,
          //   "10-10": 0,
          //   "10-11": 0,
          //   "10-13": 0,
          // },
          isLoading: loading,
        ),
        const Gap(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ColorIndicator(
              boxColor: kAccentColor,
              indicatorName: LocaleKeys.present.tr(),
            ),
            ColorIndicator(
              boxColor: kSecondaryColor,
              indicatorName: LocaleKeys.leave.tr(),
            ),
            ColorIndicator(
              boxColor: kHolidayIndicatorColor,
              indicatorName: LocaleKeys.holiday.tr(),
            ),
            ColorIndicator(
              boxColor: kHalfDayIndicatorColor,
              indicatorName: LocaleKeys.halfday.tr(),
            ),
            ColorIndicator(
              boxColor: kAbsentIndicatorColor,
              indicatorName: LocaleKeys.absent.tr(),
            ),
          ],
        ),
      ],
    );
  }
}
