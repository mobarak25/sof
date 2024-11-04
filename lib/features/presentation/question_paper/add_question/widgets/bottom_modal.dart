import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({
    super.key,
    this.totalQst = 0,
    this.marks = 00,
    required this.data,
    required this.remove,
    required this.updateMarks,
  });

  final int totalQst;
  final num marks;
  final List<TempQuestion> data;
  final Function remove;
  final VoidCallback updateMarks;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.1,
      minChildSize: 0.1,
      maxChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(
            color: bWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: bGray12,
                offset: Offset(0, -3),
                blurRadius: 5,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Column(
                children: [
                  Container(width: 40, height: 2, color: bGray12),
                  const Gap(4),
                  Container(width: 40, height: 2, color: bGray12),
                  const Gap(10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextB(
                    text: "${LocaleKeys.totalQuestion.tr()}: $totalQst,",
                    textStyle: bHead6M,
                  ),
                  TextB(
                    text: " ${LocaleKeys.marks.tr()}: $marks",
                    textStyle: bHead6M,
                  ),
                ],
              ),
              const Gap(0),
              ...List.generate(data.length, (index) {
                return Row(
                  children: [
                    Expanded(child: TextB(text: data[index].title)),
                    SizedBox(
                      width: 60,
                      child: TextFieldB(
                        paddingHeight: 8,
                        paddingWidth: 5,
                        textAlign: TextAlign.center,
                        textInputType: TextInputType.number,
                        hintText: data[index].textEditingController.text,
                        borderColor: bGray12,
                        focusNode: data[index].focusnode,
                        controller: data[index].textEditingController,
                        onChanged: (String value) {
                          updateMarks();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        remove(data[index].id);
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: bRed,
                      ),
                    )
                  ],
                );
              }),
              const Gap(10),
              ButtonB(
                heigh: 45,
                text: "Add",
                press: () {
                  Navigator.pop(context, data);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
