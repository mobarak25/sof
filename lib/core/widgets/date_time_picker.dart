import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

Future<String?> showDateTimePickerDialog(BuildContext context) async {
  String? selectedDateTime;

  await DatePicker.showDateTimePicker(
    context,
    showTitleActions: true,
    onConfirm: (date) {
      selectedDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
    },
    currentTime: DateTime.now(),
    locale: LocaleType.en,
  );

  return selectedDateTime;
}
