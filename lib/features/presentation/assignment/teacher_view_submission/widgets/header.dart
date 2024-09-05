import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.submitted,
    required this.due,
    required this.late,
  });

  final int submitted, due, late;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: bGray4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              TextB(
                text: "${LocaleKeys.submitted.tr()}: ",
                textStyle: bSub2,
              ),
              TextB(
                text: "$submitted",
                textStyle: bSub1B,
                fontColor: bPrimaryColor,
              ),
            ],
          ),
          Row(
            children: [
              TextB(
                text: "${LocaleKeys.due.tr()}: ",
                textStyle: bSub2,
              ),
              TextB(
                text: "$due",
                textStyle: bSub1B,
                fontColor: bRed,
              ),
            ],
          ),
          Row(
            children: [
              TextB(
                text: "${LocaleKeys.late.tr()}: ",
                textStyle: bSub2,
              ),
              TextB(
                text: "$late",
                textStyle: bSub1B,
                fontColor: kSecondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
