import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class GreenBox extends StatelessWidget {
  final String day, month;
  final Color? defaultColor;
  final double height;
  final double width;
  const GreenBox(
      {super.key,
      required this.month,
      required this.day,
      this.defaultColor,
      this.height = 62,
      this.width = 62});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: defaultColor == null
            ? kPrimaryColor.withOpacity(0.08)
            : defaultColor!.withOpacity(0.08),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextB(
              text: day,
              textStyle: bHead6B,
              fontColor: defaultColor ?? kPrimaryColor),
          TextB(
            text: month,
            fontColor: bGray.withOpacity(0.52),
          ),
        ],
      ),
    );
  }
}
