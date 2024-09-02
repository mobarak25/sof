import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/widgets/green_box.dart';

class DetailHeader extends StatelessWidget {
  final String day, month, title, forUser, date;
  const DetailHeader({
    super.key,
    required this.day,
    required this.month,
    required this.title,
    required this.forUser,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GreenBox(month: month, day: day),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: bHead6B),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      const TextSpan(
                          text: 'For: ',
                          style: TextStyle(
                            color: bGray,
                          )),
                      TextSpan(
                          text: forUser,
                          style: const TextStyle(
                              color: bJungleGreen, fontSize: 16)),
                    ])),
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'date: ',
                      style: TextStyle(fontSize: 16, color: bJungleGreen),
                    ),
                    TextSpan(
                      text: date,
                      style: const TextStyle(fontSize: 16, color: bJungleGreen),
                    ),
                  ],
                ),
              )
            ]),
          ),
        )
      ],
    );
  }
}
