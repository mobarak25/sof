import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/profile/student/bloc/student_profile_bloc.dart';
import 'package:school_of_future/features/presentation/profile/student/widgets/student_gaurdian.dart';
import 'package:school_of_future/features/presentation/profile/student/widgets/student_profile_inner_widget.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return BlocBuilder<StudentProfileBloc, StudentProfileState>(
      builder: (context, state) {
        final bloc = context.read<StudentProfileBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            title: LocaleKeys.profile.tr(),
          ),
          child: state.profile.data != null && state.attendance.data != null
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
                                    text: state.profile.data!.fullname!,
                                    textStyle: bHead6B,
                                    alignMent: TextAlign.center,
                                  ),
                                  const Gap(12),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextB(
                                          text: state.profile.data!.className!),
                                      const Gap(7),
                                      Container(
                                        height: 15,
                                        width: 1,
                                        color: bGray,
                                      ),
                                      const Gap(7),
                                      TextB(
                                          text:
                                              "${'Roll'.tr()} : ${state.profile.data!.classRollNo}"),
                                      const Gap(7),
                                      TextB(
                                          text:
                                              "${"Admission Number".tr()}: ${state.profile.data!.admissionNumber}"),
                                    ],
                                  ),
                                  const Gap(7),
                                  TextB(text: state.profile.data!.schoolName!),
                                  const Gap(25),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Gap(5),
                                      Expanded(
                                        child: StudentProfileInnerWidget(
                                          heading: "Class Day".tr(),
                                          valueText: state.attendance.data!
                                              .currentMonthAttendance!.present
                                              .toString(),
                                          valueTextColor: bBlack,
                                          backGroundColor:
                                              bPrimaryColor.withOpacity(0.2),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: StudentProfileInnerWidget(
                                          heading: 'Leave'.tr(),
                                          valueText: state
                                              .attendance
                                              .data!
                                              .currentMonthAttendance!
                                              .leaveCount
                                              .toString(),
                                          valueTextColor: kTextColorSecond,
                                          backGroundColor:
                                              kTextColorSecond.withOpacity(0.2),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: StudentProfileInnerWidget(
                                          heading: "Absent".tr(),
                                          valueText: state.attendance.data!
                                              .currentMonthAttendance!.absent
                                              .toString(),
                                          valueTextColor: kErrorColorSecond,
                                          backGroundColor: kErrorColorSecond
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            const Gap(15),
                            //===========About me===================
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
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextB(
                                      text: "About Me".tr(),
                                      textStyle: bBody1B,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 40,
                                      color: bBlueColor,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextB(text: "Full Name".tr()),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextB(
                                      text: state.profile.data!.fullname!,
                                      textStyle: bBaseM,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextB(text: "Address".tr()),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextB(
                                      text:
                                          state.profile.data!.permanentAddress!,
                                      textStyle: bBaseM,
                                    ),
                                    // const SizedBox(
                                    //   height: 20,
                                    // ),
                                    // TextB(text: "Date of Birth".tr()),
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    // TextB(
                                    //   text: getDate(
                                    //       value:
                                    //           state.profile.data!.dateOfBirth!,
                                    //       formate: "dd MMMM, yyyy"),
                                    //   textStyle: bBaseM,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(15),

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
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextB(
                                      text: "Guardian".tr(),
                                      textStyle: bBody1B,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 3,
                                      width: 40,
                                      color: bBlueColor,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ListView.builder(
                                      itemCount:
                                          state.profile.data!.guardians!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final curItem = state
                                            .profile.data!.guardians![index];
                                        return GuardianView(
                                          name: curItem.fullname!,
                                          phone: (curItem.mobile == null ||
                                                  curItem.mobile!.isEmpty)
                                              ? 'N/A'.tr()
                                              : curItem.mobile!,
                                          relation: curItem.relation! == 1
                                              ? 'Father'.tr()
                                              : "Mother".tr(),
                                          serial:
                                              "${index + 1}".padLeft(2, '0'),
                                        );
                                      },
                                    ),
                                  ],
                                ),
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
                                  // image: DecorationImage(
                                  //   image: CachedNetworkImageProvider(
                                  //     studentProfileResponse.data!.imageUrl ??
                                  //         'https://sportlinx360.com/sites/default/files/public_uploads/Website_content/Website_Logos/graduate-student-avatar.png',
                                  //   ),
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
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
