import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

Future<dynamic> openAcceptSheet(BuildContext context,
    {required Function press}) {
  String? markErrorText;
  String? feedbackErrorText;

  final markFocusNode = FocusNode();
  final feedbackFocusNode = FocusNode();
  final markController = TextEditingController();
  final feedbackController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: StatefulBuilder(
        builder: (ctx, myState) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              color: bWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldB(
                    textInputType: TextInputType.number,
                    fieldTitle: LocaleKeys.marks.tr(),
                    hintText: LocaleKeys.enterMark.tr(),
                    focusNode: markFocusNode,
                    controller: markController,
                    onChanged: (String mark) {},
                    isMandatory: true,
                    errorText: markErrorText ?? '',
                  ),
                  const Gap(15),
                  TextFieldB(
                    fieldTitle: LocaleKeys.feedback.tr(),
                    hintText: LocaleKeys.enterFeedBack.tr(),
                    focusNode: feedbackFocusNode,
                    controller: feedbackController,
                    maxLines: 5,
                    isMandatory: true,
                    errorText: feedbackErrorText ?? '',
                    onChanged: (String mark) {},
                  ),
                  const Gap(15),
                  ButtonB(
                    heigh: 50,
                    text: LocaleKeys.submit.tr(),
                    press: () {
                      myState(() {
                        if (markController.text.isEmpty) {
                          markErrorText = LocaleKeys.enterMark.tr();
                        } else if (feedbackController.text.isEmpty) {
                          feedbackErrorText = LocaleKeys.enterFeedBack.tr();
                        } else {
                          markErrorText = null;
                          feedbackErrorText = null;

                          press(markController.text.trim(),
                              feedbackController.text.trim());

                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
