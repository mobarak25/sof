import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ColorIndicator extends StatelessWidget {
  final Color boxColor;
  final String indicatorName;
  const ColorIndicator({
    super.key,
    required this.boxColor,
    required this.indicatorName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 18, height: 18, decoration: BoxDecoration(color: boxColor)),
        const SizedBox(width: 6),
        TextB(
            text: indicatorName,
            textStyle: bBody2.copyWith(color: kBgTextColor, fontSize: 10)),
      ],
    );
  }
}
