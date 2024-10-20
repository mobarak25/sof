import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class OverviewInfo extends StatelessWidget {
  const OverviewInfo({
    super.key,
    required this.title,
    required this.subTitle,
    this.color,
  });

  final int title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          TextB(
            text: "$title",
            textStyle: bHead6M,
            fontColor: color ?? bGray100,
          ),
          TextB(
            text: subTitle,
            textStyle: bBase2,
            fontColor: bGray52,
          ),
        ],
      ),
    );
  }
}
