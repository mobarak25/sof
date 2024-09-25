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
import 'package:school_of_future/features/presentation/resources/resources_details/bloc/resources_details_bloc.dart';

class ResourcesDetailsScreen extends StatelessWidget {
  const ResourcesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourcesDetailsBloc, ResourcesDetailsState>(
      builder: (context, state) {
        final bloc = context.read<ResourcesDetailsBloc>();
        final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.resourceDetails.tr(),
          ),
          child: data != null
              ? Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 15),
                      margin: const EdgeInsets.only(top: 15),
                      color: bWhite,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              const Gap(5),
                              TextB(
                                text: data.title ?? '',
                                textStyle: bBody2M,
                              ),
                              const Gap(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: TextB(
                                      text: data.chapter!.title ?? '',
                                      textStyle: bBase2,
                                      fontColor: bGray52,
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 10,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    color: bGray12,
                                  ),
                                  Flexible(
                                    child: TextB(
                                      text: data.subject!.name ?? '',
                                      textStyle: bBase2,
                                      fontColor: bPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Gap(30),
                          if (data.resourceType == 0)
                            DetailDescription(
                              description: data.content ?? '',
                              attachments:
                                  data.attachments!.map((e) => e.url).toList(),
                            ),
                          if (data.resourceType == 1)
                            ...List.generate(
                              data.videos!.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      TextB(
                                        text: "Video link ${index + 1} : ",
                                        textStyle: bBody2M,
                                      ),
                                      Expanded(
                                        child: TextB(
                                            text:
                                                data.videos![index].embedUrl ??
                                                    ''),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (state.isTeacher)
                      Positioned(
                        right: 0,
                        top: 15,
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
