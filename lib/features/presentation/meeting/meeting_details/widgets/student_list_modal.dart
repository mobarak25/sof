import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';

Future<void> showStudentListDialog(BuildContext context,
    {required List<BatchWiseStudentItem> students}) async {
  final size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.all(10),
        title: Stack(
          children: [
            Column(
              children: [
                TextB(
                  text: LocaleKeys.list.tr(),
                  textStyle: bHead6B,
                ),
                const Gap(10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    color: bGray4,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextB(
                        text: "Student Name",
                        textStyle: bSub2M,
                      ),
                      TextB(
                        text: "Roll",
                        textStyle: bSub2M,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close, size: 30),
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: size.height * 0.7,
          width: size.width * 0.8,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: bGray12))),
                child: Row(
                  children: [
                    Expanded(
                      child: TextB(
                        text: students[index]
                            .name!, // Assuming studentName exists in BatchWiseStudentItem
                      ),
                    ),
                    TextB(text: students[index].admissionNumber ?? '')
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
