import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/event_list_response.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.item});

  final EventItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0XFF776AA5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextB(
                  text: getDate(value: item.startDate!, formate: "dd"),
                  textStyle: bSub1B,
                  fontColor: bWhite,
                ),
                TextB(
                  text: getDate(value: item.startDate!, formate: "MMMM"),
                  textStyle: bCaption2,
                  fontColor: bWhite,
                ),
              ],
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextB(text: getDate(value: item.startDate!, formate: "EEEE")),
                const Gap(7),
                TextB(
                  text: item.title ?? '',
                  textStyle: bSub2M,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
