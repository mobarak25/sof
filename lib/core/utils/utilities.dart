//Date DateFormat===============
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
