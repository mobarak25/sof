import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

Future<String?> showDateTimePickerDialog(BuildContext context,
    {required String initialdate}) async {
  DateTime now = DateTime.now();
  DateTime date = now;

  if (initialdate.isNotEmpty) {
    try {
      DateFormat inputFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
      date = inputFormat.parse(initialdate);
    } catch (e) {
      debugPrint("Error parsing initial date: $e");
    }
  }

  String? selectedDateTime;
  await DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    onConfirm: (pickedDate) {
      selectedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
    },
    minTime: now,
    currentTime: date,
    locale: LocaleType.en,
  );

  return selectedDateTime;
}
