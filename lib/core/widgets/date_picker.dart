import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';

Future datePicker(BuildContext context,
    {required Function date, DateTime? intDate}) {
  return showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    initialDate: intDate ?? DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: bGreen, // header background color
            onPrimary: bWhite, // header text color
            onSurface: bGray100, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: bRed, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  ).then((time) {
    if (time != null) {
      date(time);
    }
  });
}
