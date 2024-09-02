import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class StudentProfileInnerWidget extends StatelessWidget {
  final Color backGroundColor;
  final Color valueTextColor;
  final String heading;
  final String valueText;
  const StudentProfileInnerWidget(
      {super.key,
      required this.backGroundColor,
      required this.valueTextColor,
      required this.heading,
      required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextB(text: heading),
          const Gap(15),
          TextB(
            text: valueText,
            fontColor: valueTextColor,
            textStyle: bBody1B,
          )
        ],
      ),
    );
  }
}
