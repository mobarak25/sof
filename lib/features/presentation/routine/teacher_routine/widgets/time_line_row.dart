import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/routine_response.dart';

class TimeLineRow extends StatelessWidget {
  const TimeLineRow({super.key, required this.data, required this.isTeacher});

  final RoutineItem data;
  final bool isTeacher;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                TextB(
                  text: data.classTimings!.name!.split(" ")[0],
                  textStyle: bBody2,
                  fontColor: bBlack,
                ),
                TextB(
                  text: time2digit(data.classTimings!.startTime!),
                  textStyle: bBase2,
                  fontColor: kTextThirdColor,
                ),
              ],
            ),
            const Gap(50),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: bWhite,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 48,
                          width: 48,
                          child: appGenerateSvgWidgetFromId(
                              id: data.subject!.subjectGroupId!),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextB(
                                text: data.subject!.name!,
                                textStyle: bBody2M,
                                fontColor: bBlack,
                              ),
                              if (data.classRoom != null)
                                TextB(
                                  text: "Room no: ${data.classRoom!.name}",
                                  textStyle: bBase2,
                                  fontColor: bGray52,
                                )
                              else
                                const TextB(
                                  text: "Room no: Not available",
                                  textStyle: bBase2,
                                  fontColor: bGray52,
                                ),
                              if (isTeacher)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextB(
                                      text: data.batch!.name!,
                                      fontColor: kPrimaryColor,
                                    ),
                                  ],
                                )
                              else
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextB(
                                      text: data.employee!.fullName!,
                                      fontColor: kPrimaryColor,
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          bottom: 0,
          left: 55,
          child: Column(
            children: [
              Container(
                width: 15,
                height: 15,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: kPrimaryColor),
                ),
              ),
              Expanded(
                child: Container(
                  width: 1,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  time2digit(String time) {
    final data = time.split(":");
    return "${data[0]}:${data[1]}";
  }
}
