import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/meeting_list_response.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard(
      {super.key,
      required this.item,
      required this.isTeacher,
      required this.pressTo});

  final MeetingItem item;
  final bool isTeacher;
  final Function pressTo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: bWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.calendar_month,
                        color: kPrimaryColor,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextB(
                            text: item.title ?? '',
                            textStyle: bSub1B,
                            fontColor: kTextAnotherColor,
                          ),
                          const Gap(5),
                          TextB(
                            text: getDate(
                                value: item.date!,
                                formate: "EEEE dd MMMM, yyyy"),
                            textStyle: bBase2,
                            fontColor: bGray52,
                          ),
                          if (isTeacher)
                            Row(
                              children: [
                                const TextB(
                                  text: "With parent of: ",
                                  textStyle: bBase2,
                                  fontColor: bGray52,
                                ),
                                Flexible(
                                  child: TextB(
                                    text: "${item.meetingMembers!.name}",
                                    textStyle: bBase2,
                                    fontColor: kPrimaryColor,
                                    maxLines: 1,
                                  ),
                                ),
                                TextB(
                                  text: " +${item.meetingMembers!.more}",
                                  textStyle: bBase2,
                                  fontColor: kPrimaryColor,
                                  maxLines: 1,
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                const TextB(
                                  text: "Coordinator: ",
                                  textStyle: bBase2,
                                  fontColor: bGray52,
                                ),
                                TextB(
                                  text: item.employee!.fullName ?? '',
                                  textStyle: bBase2,
                                  fontColor: kPrimaryColor,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                color: kSecondaryColor.withOpacity(0.05),
                child: TextB(
                  text: "${item.startTime} - ${item.endTime}",
                  textStyle: bHead6M,
                  fontColor: kSecondaryColor,
                  alignMent: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        if (isTeacher)
          Positioned(
            right: 0,
            child: PopupMenuButton(
              icon: SvgPicture.asset('assets/images/three_dots.svg'),
              itemBuilder: (context) {
                return ["Edit", "Delete"].map((action) {
                  return PopupMenuItem(
                    value: action,
                    child: Text(action),
                  );
                }).toList();
              },
              onSelected: (String value) {
                pressTo(value, item.id);
              },
            ),
          )
      ],
    );
  }
}
