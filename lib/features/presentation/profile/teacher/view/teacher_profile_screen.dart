import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/html_text.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/profile/teacher/bloc/teacher_profile_bloc.dart';
import 'package:school_of_future/features/presentation/profile/teacher/widgets/app_youtube_player.dart';
import 'package:school_of_future/features/presentation/profile/teacher/widgets/profile_contact_item.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return BlocBuilder<TeacherProfileBloc, TeacherProfileState>(
      builder: (context, state) {
        final bloc = context.read<TeacherProfileBloc>();
        final data = state.profile.data;
        return Body(
          isFullScreen: true,
          appBar: const FutureAppBar(
            title: "Teacher Profile",
          ),
          child: data != null
              ? ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    const Gap(30),
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Gap(60),
                            //========Profile section===============
                            Container(
                              decoration: const BoxDecoration(
                                color: bWhite,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.5, 1),
                                    blurRadius: 10,
                                    color: kBlackShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Gap(65),
                                  TextB(
                                    text: data.fullname ?? '',
                                    textStyle: bHead6B,
                                    alignMent: TextAlign.center,
                                  ),
                                  const Gap(12),
                                  TextB(
                                      text: data.employment!
                                              .employeeDesignation!.name ??
                                          ''),
                                  const Gap(7),
                                  TextB(text: data.schoolName ?? ''),
                                  TextB(text: data.tagline!),
                                  const Gap(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextB(
                                              text:
                                                  "${state.profile.data!.yearOfExperience}",
                                              textStyle: bHead5B,
                                              fontColor: bPrimaryColor,
                                            ),
                                            TextB(text: 'Years experience'.tr())
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 1,
                                        color: kDividerColor,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextB(
                                              text:
                                                  "${state.profile.data!.classesPerWeek}",
                                              textStyle: bHead5B,
                                              fontColor: kSecondaryColor,
                                            ),
                                            Text('class/week'.tr())
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(20)
                                ],
                              ),
                            ),
                            const Gap(15),

                            //===========About me===================
                            Container(
                              decoration: const BoxDecoration(
                                color: kWhiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.5, 1),
                                    blurRadius: 10,
                                    color: kBlackShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 16.0, right: 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextB(
                                              text: "About Me".tr(),
                                              textStyle: bBody1B,
                                            ),

                                            // ProfileCommonEditSaveButton(
                                            //   onTap: () {},
                                            // ),
                                          ],
                                        ),
                                        const Gap(5),
                                        Container(
                                          height: 3,
                                          width: 40,
                                          color: kBlueColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 16,
                                      left: 16,
                                      right: 16,
                                    ),
                                    child: YoutubeVideoPlayerFlutter(),

                                    //  AppYouTubePlayer(
                                    //   videoId:
                                    //       state.profile.data!.bioMediaUrl ==
                                    //               null
                                    //           ? 'e9P8uGkdwko'
                                    //           : state.profile.data!.bioMediaUrl!
                                    //               .split('=')
                                    //               .last,
                                    // ),
                                  ),
                                  HtmlText(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 13,
                                    ),
                                    state.profile.data!.bio ?? '',
                                  ),
                                ],
                              ),
                            ),

                            //===========Contact===================
                            const Gap(15),
                            Container(
                              decoration: const BoxDecoration(
                                color: kWhiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.5, 1),
                                    blurRadius: 10,
                                    color: kBlackShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 16.0, right: 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextB(
                                              text: "Contact".tr(),
                                              textStyle: bBody1B,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 3,
                                          width: 40,
                                          color: kBlueColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ProfileContactItem(
                                    svgIconLocation:
                                        'assets/images/profile_email_icon.svg',
                                    title: "Email".tr(),
                                    bodyText:
                                        state.profile.data!.email ?? "N/A".tr(),
                                  ),
                                  ProfileContactItem(
                                    svgIconLocation:
                                        'assets/images/phone_svg.svg',
                                    title: LocaleKeys.phone.tr(),
                                    bodyText: state.profile.data!.mobile ??
                                        "N/A".tr(),
                                  ),
                                  ProfileContactItem(
                                    svgIconLocation:
                                        'assets/images/dob_svg.svg',
                                    title: LocaleKeys.dateOfBirth.tr(),
                                    bodyText: getDate(
                                        value: state.profile.data!.dob ?? '',
                                        formate: "dd MMMM, yyyy"),
                                  ),
                                ],
                              ),
                            ),

                            //===========Experiences===================
                            const Gap(15),
                            Container(
                              decoration: const BoxDecoration(
                                color: kWhiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.5, 1),
                                    blurRadius: 10,
                                    color: kBlackShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 16.0, right: 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextB(
                                              text: LocaleKeys.experiences.tr(),
                                              textStyle: bBody1B,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 3,
                                          width: 40,
                                          color: kBlueColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ...List.generate(
                                    data.exprience!.length,
                                    (index) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: bGray12.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          TextB(
                                            text:
                                                "${index + 1}".padLeft(2, "0"),
                                            textStyle: bHead5M,
                                            fontColor: bGray32,
                                          ),
                                          const Gap(11),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextB(
                                                text: data.exprience![index]
                                                        .designation ??
                                                    '',
                                                textStyle: bBody1B,
                                              ),
                                              const Gap(4),
                                              TextB(
                                                text: data.exprience![index]
                                                        .organizationName ??
                                                    '',
                                                textStyle: bSub2M,
                                                fontColor: kTextDefaultColor
                                                    .withOpacity(0.5),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //===========qualification===================
                            const Gap(15),
                            Container(
                              decoration: const BoxDecoration(
                                color: kWhiteColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.5, 1),
                                    blurRadius: 10,
                                    color: kBlackShadowColor,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, left: 16.0, right: 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextB(
                                              text: LocaleKeys.proProfiles.tr(),
                                              textStyle: bBody1B,
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        Container(
                                          height: 3,
                                          width: 40,
                                          color: kBlueColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ...List.generate(
                                    data.professionalProfiles!.length,
                                    (index) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: bGray12.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          TextB(
                                            text:
                                                "${index + 1}".padLeft(2, "0"),
                                            textStyle: bHead5M,
                                            fontColor: bGray32,
                                          ),
                                          const Gap(11),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextB(
                                                text: data
                                                        .professionalProfiles![
                                                            index]
                                                        .key ??
                                                    '',
                                                textStyle: bBody1B,
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              TextB(
                                                text: data
                                                        .professionalProfiles![
                                                            index]
                                                        .value ??
                                                    '',
                                                textStyle: bSub2M,
                                                fontColor: kTextDefaultColor
                                                    .withOpacity(0.5),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const Gap(100),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: bWhite,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: bGray, width: 1),
                                ),
                                child: NetworkImageB(
                                    imageUrl: state.profile.data!.image!),
                              ),
                            ],
                          ),
                        )
                      ],
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
