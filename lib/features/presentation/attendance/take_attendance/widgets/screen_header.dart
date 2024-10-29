import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader(
      {super.key,
      required this.present,
      required this.absent,
      required this.late,
      required this.leave});

  final int present;
  final int absent;
  final int late;
  final int leave;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: const BoxDecoration(
        color: bGray4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const TextB(
                text: "Present: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "$present",
                textStyle: bBody1B,
                fontColor: kPrimaryColor,
              ),
            ],
          ),
          Row(
            children: [
              const TextB(
                text: "Late: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "$late",
                textStyle: bBody1B,
                fontColor: kSecondaryColor,
              ),
            ],
          ),
          Row(
            children: [
              const TextB(
                text: "Absent: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "$absent",
                textStyle: bBody1B,
                fontColor: bRed,
              ),
            ],
          ),
          Row(
            children: [
              const TextB(
                text: "Leave: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "$leave",
                textStyle: bBody1B,
                fontColor: kSecondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
