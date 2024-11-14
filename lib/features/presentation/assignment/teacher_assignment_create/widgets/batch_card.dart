import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';

class BachCard extends StatelessWidget {
  const BachCard({
    super.key,
    required this.assignToBatchId,
    required this.selectedBatchName,
    required this.selecteClassName,
    required this.listOfCheckUncheckStudent,
    required this.press,
  });

  final List<int> assignToBatchId;
  final List<String> selectedBatchName;
  final String selecteClassName;
  final Function press;
  final List<List<CheckUncheckStudents>>? listOfCheckUncheckStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(assignToBatchId.length, (index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: kOpaqueErrorColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextB(
                      text:
                          "${numberOfStudent(listOfCheckUncheckStudent![index])} of ${listOfCheckUncheckStudent![index].length}  Students from $selecteClassName-${selectedBatchName[index]} is selected",
                      textStyle: bBody2,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      press(index);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: kSecondaryColor.withOpacity(0.24),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10)
          ],
        );
      }),
    );
  }

  int numberOfStudent(List<CheckUncheckStudents> list) {
    int countOfOnes = list.where((item) => item.isChecked == true).length;
    return countOfOnes;
  }
}
