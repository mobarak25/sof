import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

Future<dynamic> openDenySheet(BuildContext context, {required Function press}) {
  String? feedbackErrorText;

  final feedbackFocusNode = FocusNode();
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
                        if (feedbackController.text.isEmpty) {
                          feedbackErrorText = LocaleKeys.enterFeedBack.tr();
                        } else {
                          feedbackErrorText = null;
                          press(feedbackController.text.trim());
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
