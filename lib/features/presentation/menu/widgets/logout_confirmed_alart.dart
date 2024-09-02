import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
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
        title: TextB(
          text: LocaleKeys.logout.tr(),
          textStyle: bHead6B,
        ),
        content: Text('${LocaleKeys.logoutConfirm.tr()} ?'),
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
                  text: LocaleKeys.cancel.tr(),
                  press: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const Gap(40),
              Expanded(
                child: ButtonB(
                  heigh: 60,
                  text: LocaleKeys.yes.tr(),
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
