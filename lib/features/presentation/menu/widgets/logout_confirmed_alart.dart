import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';

Future<void> showConfirmedDialog(BuildContext context,
    {required VoidCallback pressToYes}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: const TextB(
          text: 'Logout',
          textStyle: bHead6B,
        ),
        content: const Text('Are you sure you want to logout? '),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ButtonB(
                  bgColor: bWhite,
                  borderColor: bJungleGreen,
                  textColor: bJungleGreen,
                  heigh: 60,
                  text: "Cancel",
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const Gap(40),
              Expanded(
                child: ButtonB(
                  heigh: 60,
                  text: "Yes",
                  press: () {
                    pressToYes();
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
