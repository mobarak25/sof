import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

Future<String?> showTimePickerDialog(BuildContext context,
    {required DateTime initialTime}) async {
  String? selectedTime;

  await DatePicker.showTimePicker(
    context,
    showTitleActions: true,
    onConfirm: (date) {
      selectedTime = DateFormat('hh:mm a').format(date).toUpperCase();
    },
    currentTime: initialTime,
    locale: LocaleType.en,
  );
  return selectedTime;
}
