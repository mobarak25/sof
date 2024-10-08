import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/syllabus_teacher_response.dart';

class SyllabusCard extends StatelessWidget {
  const SyllabusCard({
    super.key,
    required this.data,
    required this.pressToDel,
    required this.pressToView,
  });

  final SyllabusClassQuizTest data;
  final Function pressToDel;
  final Function pressToView;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: bWhite,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextB(
                                text: getDate(value: data.date!, formate: "dd"),
                                textStyle: bHead6B,
                                fontColor: kPrimaryColor),
                            TextB(
                              text: getDate(value: data.date!, formate: "MMM"),
                              textStyle: bBase2,
                              fontColor: bGray52,
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextB(
                              text: data.title ?? '',
                              textStyle: bBody2M,
                              fontColor: kTextAnotherColor,
                            ),
                            Row(
                              children: [
                                const TextB(
                                  text: 'Subject:',
                                  textStyle: bBase2,
                                  fontColor: bGray52,
                                ),
                                TextB(
                                  text: data.subject!.name!,
                                  textStyle: bBase2,
                                  fontColor: kPrimaryColor,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const TextB(
                                  text: 'Total Mark: ',
                                  textStyle: bBase2,
                                  fontColor: bGray52,
                                ),
                                TextB(
                                  text: "${data.mark}",
                                  textStyle: bBase2,
                                  fontColor: kPrimaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonB(
                          heigh: 50,
                          text: "Edit",
                          textColor: kSecondaryColor,
                          bgColor: kSecondaryColor.withOpacity(0.1),
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              teacherSyllabusCreateScreen,
                              arguments: data.id,
                            );
                          },
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: ButtonB(
                          heigh: 50,
                          text: "View",
                          press: () {
                            pressToView(data.id);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 15,
              child: PopupMenuButton(
                icon: SvgPicture.asset('assets/images/three_dots.svg'),
                itemBuilder: (context) {
                  return ["Delete"].map((action) {
                    return PopupMenuItem(
                      value: action,
                      child: Text(action),
                    );
                  }).toList();
                },
                onSelected: (String value) {
                  pressToDel(value, data.id);
                },
              ),
            )
          ],
        ),
        const Gap(15),
      ],
    );
  }
}
