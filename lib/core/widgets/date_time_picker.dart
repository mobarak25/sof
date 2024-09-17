import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

Future<String?> showDateTimePickerDialog(BuildContext context,
    {required String initialdate}) async {
  String? selectedDateTime;
  String now = DateTime.now().toString();
  DateTime date = DateTime.parse(initialdate.isEmpty ? now : initialdate);
  await DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    onConfirm: (date) {
      selectedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
    },
    minTime: DateTime.now(),
    currentTime: date,
    locale: LocaleType.en,
  );

  return selectedDateTime;
}
