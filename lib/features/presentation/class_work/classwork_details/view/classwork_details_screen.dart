import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/detail_description.dart';
import 'package:school_of_future/features/presentation/class_work/classwork_details/bloc/classwork_details_bloc.dart';

class ClassworkDetailsScreen extends StatelessWidget {
  const ClassworkDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassworkDetailsBloc, ClassworkDetailsState>(
      builder: (context, state) {
        final bloc = context.read<ClassworkDetailsBloc>();
        final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.classWorkDetails.tr(),
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
                                      id: data.subjectGroupId!),
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
                                      text: data.subject ?? '',
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
                                        TextB(
                                          text: getDate(
                                              value: data.publishedAt!,
                                              formate: "dd MMM, yyyy"),
                                          fontColor: kPrimaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(30),
                          DetailDescription(
                            description: data.description ?? '',
                            attachments: data.attachment!,
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
