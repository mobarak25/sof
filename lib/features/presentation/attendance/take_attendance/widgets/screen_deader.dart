import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key});

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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TextB(
                text: "Present: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "17",
                textStyle: bBody1B,
                fontColor: kPrimaryColor,
              ),
            ],
          ),
          Row(
            children: [
              TextB(
                text: "Absent: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "17",
                textStyle: bBody1B,
                fontColor: bRed,
              ),
            ],
          ),
          Row(
            children: [
              TextB(
                text: "Late: ",
                textStyle: bBody2,
              ),
              TextB(
                text: "17",
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
