import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String getDate({required String value, required String formate}) {
  DateTime tempDate = DateTime.parse(value);
  return DateFormat(formate).format(tempDate);
}

//Multipart Image===============
class ImageFile {
  const ImageFile({required this.name, required this.file});

  final String name;
  final XFile file;
}

bool isNumeric(String s) {
  if (s == '') {
    return false;
  }
  return double.tryParse(s) != null;
}

String getToday({required String formate}) {
  return DateFormat(formate).format(DateTime.now());
}

class VisitImage {
  const VisitImage({required this.id, required this.img});

  final int id;
  final String img;
}

String totalTime(String val) {
  List temp = val.split('.');

  if (temp.length > 1) {
    temp[1] = ((60 * int.parse(temp[1])) / 100).ceil().toString();
  }

  if (temp.length > 1) {
    return "${temp[0]}h:${temp[1]}m";
  } else {
    return "${temp[0]}h";
  }
}

int parseToInt(String value) {
  //value = 100,275.00
  String sanitizedString = value.replaceAll(',', '').split('.')[0];
  int number = int.parse(sanitizedString);
  return number;
}

// Check plural=============================
extension PluralExtension on num {
  String plural(String singularWord, [String pluralLetters = "s"]) {
    return this > 1
        ? "$this $singularWord$pluralLetters"
        : "$this $singularWord";
  }
}

class DropdownItem {
  const DropdownItem({required this.name, required this.value});
  final String name;
  final dynamic value;
}

class PopupItem {
  const PopupItem({required this.title, required this.value});

  final String title;
  final String value;
}

class TabItem {
  const TabItem({required this.title, required this.image});
  final String title;
  final String image;
}

T data<T>(T value) {
  return value;
}

String buildUrl(String baseUrl, Map<String, dynamic> queryParams) {
  final queryString = queryParams.entries
      .where((entry) =>
          entry.value.toString().isNotEmpty &&
          entry.value.toString() != '-1') // Only include non-empty values
      .map((entry) =>
          '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');

  return queryString.isNotEmpty && queryString != "-1"
      ? '$baseUrl?$queryString'
      : baseUrl;
}

String getFileName(String path) {
  return path.split('/').last;
}

class CheckUncheckStudents {
  const CheckUncheckStudents({
    required this.id,
    required this.isChecked,
    required this.name,
    required this.admissionRoll,
  });

  final int id;
  final bool isChecked;
  final String name;
  final String admissionRoll;
}

class CheckUncheckResources {
  const CheckUncheckResources({
    required this.id,
    required this.isChecked,
    required this.name,
    required this.chapterName,
    required this.thumbImg,
  });

  final int id;
  final bool isChecked;
  final String name;
  final String chapterName;
  final String thumbImg;
}

class AgendaInput {
  const AgendaInput({
    required this.focusnode,
    required this.textEditingController,
  });
  final FocusNode focusnode;
  final TextEditingController textEditingController;
}

class MCQOptions {
  const MCQOptions({
    required this.focusnode,
    required this.textEditingController,
  });
  final FocusNode focusnode;
  final TextEditingController textEditingController;
}

String generateValidUrl(String url) {
  // Replace backslashes with empty string to remove them
  String validUrl = url.replaceAll(r'\\', '');

  // Decode any percent-encoded characters
  validUrl = Uri.decodeComponent(validUrl);

  return validUrl;
}

DateTime getLastDayOfMonth(DateTime date) {
  DateTime firstDayOfNextMonth = (date.month < 12)
      ? DateTime(date.year, date.month + 1, 1)
      : DateTime(date.year + 1, 1, 1); // If December, go to next year

  return firstDayOfNextMonth.subtract(const Duration(days: 1));
}

DateTime getFirstDateOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

class QstTempChecked {
  QstTempChecked({
    required this.id,
    required this.isChecked,
  });

  final int id;
  final bool isChecked;
}

class TempQuestion {
  TempQuestion({
    required this.id,
    required this.title,
    required this.focusnode,
    required this.textEditingController,
  });

  final int id;
  final String title;
  final FocusNode focusnode;
  final TextEditingController textEditingController;
}

class QuizAns {
  QuizAns({
    required this.questionId,
    required this.type,
    required this.answer,
    required this.focusnode,
    required this.textEditingController,
  });
  final int questionId;
  final int type;
  final String answer;
  final FocusNode focusnode;
  final TextEditingController textEditingController;
}

DateTime convertToDateTime(String time) {
  if (time.isNotEmpty) {
    DateTime dateTime = DateFormat.jm().parse(time);
    return dateTime;
  } else {
    return DateTime.now();
  }
}




// {
//     "quiz_id":25,
//     "is_final_submit":1,
//     "answers":[
//         {
//             "question_id": 50,
//             "type":1,
//             "answer":94
//         },{
//             "question_id": 52,
//             "type":2,
//             "answer":97
//         },{
//             "question_id": 53,
//             "type":3,
//             "answer":"ans of short question"
//         }
//     ]
// }
