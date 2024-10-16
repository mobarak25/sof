import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/detail_description.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/leave/teacher_leave_details/bloc/teacher_leave_details_bloc.dart';

class TeacherLeaveDetailsScreen extends StatelessWidget {
  const TeacherLeaveDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherLeaveDetailsBloc, TeacherLeaveDetailsState>(
      builder: (context, state) {
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.leaveDetails.tr(),
          ),
          child: state.details.data != null
              ? ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(17, 10, 17, 120),
                      margin: const EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                          color: bWhite,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          TextB(
                            text: state.details.data!.comment ?? '',
                            textStyle: bHead6B,
                            alignMent: TextAlign.center,
                          ),
                          const Gap(8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${LocaleKeys.type.tr()}: ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text: state.details.data!.leaveType!.name!,
                                  style: const TextStyle(color: bJungleGreen),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${LocaleKeys.date.tr()}: ",
                                  style: const TextStyle(color: bGray),
                                ),
                                TextSpan(
                                  text:
                                      "${state.details.data!.fromDate} - ${state.details.data!.toDate}",
                                  style: const TextStyle(color: bJungleGreen),
                                ),
                              ],
                            ),
                          ),
                          const Gap(30),
                          if (state.details.data!.status == 1)
                            ButtonB(
                              heigh: 55,
                              bgColor: kSecondaryColor,
                              text: LocaleKeys.pending.tr(),
                              press: () {},
                            )
                          else if (state.details.data!.status == 2)
                            ButtonB(
                              heigh: 55,
                              text: LocaleKeys.accepted.tr(),
                              press: () {},
                            )
                          else
                            ButtonB(
                              heigh: 55,
                              bgColor: kErrorColor.withOpacity(0.15),
                              textColor: kErrorColor,
                              text: LocaleKeys.rejected.tr(),
                              press: () {},
                            ),
                          const Gap(30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextB(
                                text: "Employee details",
                                textStyle: bSub1B,
                              ),
                              const Gap(10),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: bGray12),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 92,
                                      height: 92,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(color: bGray12)),
                                      child: SvgPicture.asset(avaterSvg),
                                    ),
                                    const Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextB(
                                          text:
                                              "Code : ${state.details.data!.employee!.shortCode}",
                                          textStyle: bSub2,
                                          fontColor: bGray52,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 49),
                          DetailDescription(
                            description: state.details.data!.comment!,
                            attachments: [state.details.data!.attachment],
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
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
