import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class CalendarHighlight extends StatelessWidget {
  final String day;
  final Color bgColor;
  final Color? textColor;

  const CalendarHighlight({
    super.key,
    this.textColor,
    required this.day,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 35,
        width: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: TextB(
          text: day,
          textStyle: bBody2,
          fontColor: textColor != null ? textColor! : kWhiteColor,
        ),
      ),
    );
  }
}
