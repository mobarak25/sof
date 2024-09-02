import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';

Future<void> labguageModal(BuildContext context,
    {required VoidCallback pressToYes,
    required VoidCallback pressToEn,
    required VoidCallback pressToBD}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;

      String language = context.locale.toString();
      return AlertDialog(
        title: TextB(
          text: 'PLEASE SELECT YOUR LANGUAGE !'.tr(),
          textStyle: bHead6B,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(15),
            InkWell(
              onTap: () async {
                await context.setLocale(const Locale('en', 'US'));
              },
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: language == 'en_US' ? bPrimaryColor : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextB(
                  text: 'English',
                  textStyle: bHead6B,
                  fontColor: language == 'en_US' ? bWhite : null,
                  alignMent: TextAlign.center,
                ),
              ),
            ),
            const Gap(15),
            InkWell(
              onTap: () async {
                await context.setLocale(const Locale('bn', 'BD'));
              },
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: language == 'bn_BD' ? bPrimaryColor : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextB(
                  text: 'বাংলা',
                  textStyle: bHead6B,
                  fontColor: language == 'bn_BD' ? bWhite : null,
                  alignMent: TextAlign.center,
                ),
              ),
            ),
            const Gap(15),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonB(
                heigh: 60,
                text: "Okay".tr(),
                press: () {
                  pressToYes();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
