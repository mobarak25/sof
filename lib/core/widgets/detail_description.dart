import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/html_text.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/widgets/item_attachment.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDescription extends StatelessWidget {
  final String description;
  final List<String?> attachments;
  final TextStyle? customTitleTextStyle;

  const DetailDescription(
      {super.key,
      required this.description,
      required this.attachments,
      this.customTitleTextStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.description.tr(),
          style: customTitleTextStyle,
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            ListView.builder(
              itemBuilder: (context, position) {
                return ItemAttachment(
                  action: () {
                    if (isImage(attachments[position]!.split('/').last)) {
                      Navigator.of(context).pushNamed(imageViewScreen,
                          arguments: attachments[position]);
                    } else {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                          docViewScreen,
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
            const SizedBox(
              height: 8,
            ),
            Container(
              //margin: EdgeInsets.only(top: 24),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kHtmlBodyBGColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomHtmlThird(htmlText: description),
              //child: CustomHtmlText(htmlText: description),
            ),
          ],
        ),
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
