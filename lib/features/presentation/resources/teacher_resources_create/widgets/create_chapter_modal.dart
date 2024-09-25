import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

Future<void> showChapterCreateDialog(BuildContext context,
    {required Function getChapterText}) async {
  String? errorText;
  final chapterController = TextEditingController();
  final chapterFocusnode = FocusNode();
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        title: TextB(
          text: LocaleKeys.createChapter.tr(),
          textStyle: bHead6B,
        ),
        content: StatefulBuilder(builder: (ctx, myState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldB(
                isMandatory: true,
                fieldTitle: LocaleKeys.chapterName.tr(),
                hintText: LocaleKeys.enterChapterName.tr(),
                borderColor: bGray12,
                focusNode: chapterFocusnode,
                controller: chapterController,
                onChanged: (String value) {
                  // bloc.add(ChangeTitle(title: value));
                },
                errorText: errorText ?? '',
              ),
              const Gap(20),
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
                      text: LocaleKeys.ok.tr(),
                      press: () {
                        myState(() {
                          if (chapterController.text.isEmpty) {
                            errorText = LocaleKeys.enterChapterName.tr();
                          } else {
                            errorText = null;
                            getChapterText(chapterController.text.trim());
                            Navigator.of(ctx).pop();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      );
    },
  );
}
