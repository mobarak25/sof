import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';

Future<void> showTypeDialog(BuildContext context,
    {required VoidCallback pressToYes}) async {
  bool isLoading = false;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: TextB(
          text: LocaleKeys.pleaseChooseType.tr(),
          textStyle: bHead6B,
        ),
        content: StatefulBuilder(
          builder: (ctx, myState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonB(
                  loading: isLoading,
                  iconPosition: "left",
                  heigh: 55,
                  text: LocaleKeys.classWise.tr(),
                  press: () {
                    pressToYes();
                    myState(() {
                      isLoading = true;
                    });
                  },
                ),
                const Gap(10),
                ButtonB(
                  loading: isLoading,
                  iconPosition: "left",
                  heigh: 55,
                  text: LocaleKeys.subjectWise.tr(),
                  press: () {
                    pressToYes();
                    myState(() {
                      isLoading = true;
                    });
                  },
                ),
              ],
            );
          },
        ),

        // actions: [
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Expanded(
        //         child: ButtonB(
        //           bgColor: bWhite,
        //           borderColor: bJungleGreen,
        //           textColor: bJungleGreen,
        //           heigh: 60,
        //           text: LocaleKeys.cancel.tr(),
        //           press: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ),
        //       const Gap(40),
        //    ],
        //   ),
        // ],
      );
    },
  );
}
