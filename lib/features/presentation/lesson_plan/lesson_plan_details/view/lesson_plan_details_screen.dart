import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_details/bloc/lesson_plan_details_bloc.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_details/widgets/plan_details_description.dart';

class LessonPlanDetailsScreen extends StatelessWidget {
  const LessonPlanDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonPlanDetailsBloc, LessonPlanDetailsState>(
      builder: (context, state) {
        final bloc = context.read<LessonPlanDetailsBloc>();
        final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.lPlanDetails.tr(),
          ),
          child: data != null
              ? Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 15),
                      color: bInnerBg,
                      child: ListView(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: appGenerateSvgWidgetFromId(
                                      id: data.subject!.subjectGroupId!),
                                ),
                              ),
                              const Gap(15),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextB(
                                      text: data.title ?? '',
                                      textStyle: bHead6B,
                                      fontColor: kTextAnotherColor,
                                      maxLines: 2,
                                    ),
                                    const Gap(5),
                                    TextB(
                                      text: data.subject!.name ?? '',
                                      fontSize: 13,
                                      fontColor: kPrimaryColor,
                                    ),
                                    const Gap(5),
                                    Row(
                                      children: [
                                        TextB(
                                          text: '${LocaleKeys.date.tr()}: ',
                                          fontColor: kTextDefaultColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(30),
                          PlanDescription(
                            description: data.content ?? '',
                            objectives: data.objectives ?? '',
                            attachments:
                                data.attachments!.map((e) => e.url).toList(),
                            resources: data.resources!,
                            pressToRersource: (int resourceId) {
                              Navigator.of(context).pushNamed(
                                resourcesDetailsScreen,
                                arguments: resourceId,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    if (state.isTeacher)
                      Positioned(
                        right: 0,
                        child: PopupMenuButton(
                          icon:
                              SvgPicture.asset('assets/images/three_dots.svg'),
                          itemBuilder: (context) {
                            return ["Edit", "Delete"].map((action) {
                              return PopupMenuItem(
                                value: action,
                                child: Text(action),
                              );
                            }).toList();
                          },
                          onSelected: (String value) {
                            bloc.add(PressToDelEdit(id: data.id!, type: value));
                          },
                        ),
                      )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
