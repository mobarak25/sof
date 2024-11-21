import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class QuizDtlsTardTopInfo extends StatelessWidget {
  const QuizDtlsTardTopInfo({
    super.key,
    required this.title,
    required this.value,
    this.valueColor = kPrimaryColor,
  });

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextB(
            text: title,
            textStyle: bBase2,
            fontColor: bBlack,
            alignMent: TextAlign.center,
            maxLines: 1,
          ),
          const Gap(5),
          TextB(
            text: value,
            textStyle: bHead5B,
            fontColor: valueColor,
          ),
        ],
      ),
    );
  }
}
