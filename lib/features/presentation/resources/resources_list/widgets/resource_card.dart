import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/resources_response.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard(
      {super.key,
      required this.item,
      required this.pressTo,
      required this.isTeacher});

  final ResourcesItem item;
  final Function pressTo;
  final bool isTeacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                child: NetworkImageB(
                  imageUrl: item.thumbnail!,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    TextB(
                      text: item.subject!.name!,
                      textStyle: bBase2,
                      fontColor: bGray52,
                      maxLines: 1,
                    ),
                    TextB(
                      text: item.title!,
                      textStyle: bBody2M,
                      fontColor: bGray100,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
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
      ),
    );
  }
}
