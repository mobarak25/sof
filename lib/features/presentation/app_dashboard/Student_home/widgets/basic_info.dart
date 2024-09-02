import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class BasicInfo extends StatelessWidget {
  final String imageUrl, name, classInfo, roll, schoolName;
  final bool isLoading;
  final bool isFailed;

  const BasicInfo({
    required this.imageUrl,
    required this.name,
    required this.classInfo,
    required this.roll,
    required this.schoolName,
    required this.isLoading,
    required this.isFailed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhiteColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        color: kPrimaryColor.withOpacity(0.08),
        child: Row(
          children: [
            if (imageUrl.isNotEmpty)
              Container(
                height: 86,
                width: 86,
                decoration: BoxDecoration(
                  border: Border.all(color: kSecondaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                ),
              )
            else
              Container(
                height: 86,
                width: 86,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: kSecondaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset("assets/images/avatar.svg"),
              ),
            const SizedBox(
              width: 13,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextB(
                    text: name,
                    maxLines: 2,
                    textStyle: bBody2M,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextB(
                    text: '$classInfo | $roll',
                    fontColor: kLabelColor,
                    textStyle: bCaption2,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextB(
                    text: schoolName,
                    fontColor: kLabelColor,
                    textStyle: bCaption2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
