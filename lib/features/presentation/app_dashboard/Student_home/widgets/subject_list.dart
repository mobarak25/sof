import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key, required this.subjects});

  final List<SubjectItem> subjects;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 19),
      width: double.infinity,
      height: 85,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: subjects.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 55,
                    width: 55,
                    child: appGenerateSvgWidgetFromId(
                        id: subjects[position].subjectGroupId!),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: 65,
                    child: TextB(
                      text: subjects[position].name!,
                      maxLines: 2,
                      textStyle: bCaption2,
                      fontColor: kMenuTextColor,
                      alignMent: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 22,
          );
        },
      ),
    );
  }
}
