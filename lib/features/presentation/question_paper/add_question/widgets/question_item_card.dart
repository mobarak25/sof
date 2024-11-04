import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/question_bank_response.dart';

class QuestionItemCard extends StatelessWidget {
  const QuestionItemCard({
    super.key,
    required this.data,
    required this.isChecked,
    required this.press,
  });
  final QuestionItem data;
  final bool isChecked;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: bWhite,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () {},
          child: CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.leading,
            title: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextB(
                    text: data.title ?? '',
                    textStyle: bBase,
                  ),
                  const SizedBox(height: 5), // Add some spacing
                  Row(
                    children: [
                      Row(
                        children: [
                          TextB(
                            text: '${LocaleKeys.version.tr()}: ',
                            textStyle: bBase2,
                          ),
                          TextB(
                            text: "${data.subject?.version?.name ?? ''}, ",
                            textStyle: bBase2,
                            fontColor: kPrimaryColor,
                          ),
                          TextB(
                            text: data.subject?.subjectClass?.name ?? '',
                            textStyle: bBase2,
                            fontColor: kPrimaryColor,
                          )
                        ],
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            TextB(
                              text: ', ${LocaleKeys.subject.tr()}: ',
                              textStyle: bBase2,
                            ),
                            Expanded(
                              child: TextB(
                                text: data.subject?.name ?? '',
                                textStyle: bBase2,
                                fontColor: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5), // Add some spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            TextB(
                              text: '${LocaleKeys.type.tr()}: ',
                              maxLines: 1,
                              textStyle: bBase2,
                            ),
                            TextB(
                              text: data.type == 1
                                  ? 'MCQ'
                                  : data.type == 2
                                      ? "True False"
                                      : "Short Qst",
                              textStyle: bBase2,
                              fontColor: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          TextB(
                            text: '${LocaleKeys.marks.tr()}: ',
                            maxLines: 1,
                            textStyle: bBase2,
                          ),
                          TextB(
                            text: '${data.mark}',
                            maxLines: 1,
                            textStyle: bBase2,
                            fontColor: kPrimaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            value: isChecked,
            onChanged: (bool? value) {
              press(value);
            },
          ),
        ),
      ),
    );
  }
}
