import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/attendance/absent_student/bloc/absent_student_bloc.dart';

class AbsentStudentsScreen extends StatelessWidget {
  const AbsentStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsentStudentBloc, AbsentStudentState>(
      builder: (context, state) {
        final bloc = context.read<AbsentStudentBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.absent.tr(),
            //isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0),
            color: bWhite,
            child: state.students.data != null
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: bGray4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextB(
                              text: LocaleKeys.detail.tr(),
                              textStyle: bBody1M,
                            ),
                            TextB(
                              text: LocaleKeys.days.tr(),
                              textStyle: bBody1M,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          itemCount: state.students.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final date = state.students.data!;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      padding: const EdgeInsets.all(5),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(color: bGray12)),
                                      child: SvgPicture.asset(avaterSvg),
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextB(
                                            text: date[index].fullName!,
                                            textStyle: bSub2M,
                                          ),
                                          TextB(
                                            text:
                                                "Version: ${date[index].versionName!}",
                                            textStyle: bBase2,
                                            fontColor: bGray32,
                                          ),
                                          TextB(
                                            text:
                                                "Class: ${date[index].className!} - ${date[index].sectionName!}",
                                            textStyle: bBase2,
                                            fontColor: bGray32,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bGray32)),
                                      child: TextB(
                                        text: "${date[index].absentInDays!}",
                                        textStyle: bBody1B,
                                      ),
                                    )
                                  ],
                                ),
                                const Gap(20),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
