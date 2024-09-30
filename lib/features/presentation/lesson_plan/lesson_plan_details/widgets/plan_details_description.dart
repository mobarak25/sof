import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/html_text.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/lesson_plan_details_response.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/widgets/item_attachment.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanDescription extends StatelessWidget {
  final String description;
  final String objectives;
  final List<String?> attachments;
  final List<Resource> resources;
  final TextStyle? customTitleTextStyle;
  final Function pressToRersource;

  const PlanDescription({
    super.key,
    required this.description,
    required this.objectives,
    required this.attachments,
    required this.resources,
    this.customTitleTextStyle,
    required this.pressToRersource,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextB(
          text: LocaleKeys.notes.tr(),
          textStyle: bHead6M,
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kHtmlBodyBGColor,
              ),
              child: CustomHtmlThird(htmlText: description),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              itemBuilder: (context, position) {
                return ItemAttachment(
                  action: () {
                    if (isImage(attachments[position]!.split('/').last)) {
                      Navigator.of(context).pushNamed(imageViewScreen,
                          arguments: attachments[position]);
                    } else {
                      Navigator.of(context).pushNamed(docViewScreen,
                          arguments: attachments[position]);
                    }
                  },
                  text: attachments[position] != null
                      ? attachments[position]!.split('/').last
                      : 'N/A',
                  downloadRequest: () async {
                    await canLaunch(attachments[position] ?? '')
                        ? await launch(attachments[position] ?? '')
                        : throw '${LocaleKeys.couldNotLaunch.tr()} ${attachments[position]}';
                  },
                );
              },
              itemCount: attachments.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            const Gap(15),
            ...List.generate(
              resources.length,
              (index) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pressToRersource(resources[index].resouce!.id);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(color: bGray12),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SvgPicture.asset(
                              "assets/images/dashboard_resource_icon.svg"
                              // colorFilter: ColorFilter.mode(svgColor, BlendMode.srcIn),
                              ),
                        ),
                        const Gap(12),
                        TextB(
                          text: resources[index].resouce!.title ?? '',
                          fontColor: bBlack,
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ],
        ),
        const Gap(30),
        TextB(
          text: LocaleKeys.learningObjectives.tr(),
          textStyle: bHead6M,
        ),
        CustomHtmlThird(htmlText: objectives),
      ],
    );
  }

  bool isImage(String imageName) {
    final extension = imageName.split('.').last.toLowerCase();
    if (extension == 'jpeg' || extension == 'jpg' || extension == 'png') {
      return true;
    } else {
      return false;
    }
  }
}
