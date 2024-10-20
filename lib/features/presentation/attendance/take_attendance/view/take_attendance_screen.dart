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
import 'package:school_of_future/features/presentation/attendance/take_attendance/bloc/take_attendance_bloc.dart';
import 'package:school_of_future/features/presentation/attendance/take_attendance/widgets/screen_deader.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TakeAttendanceBloc, TakeAttendanceState>(
      builder: (context, state) {
        final bloc = context.read<TakeAttendanceBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.takeAttendance.tr(),
            //isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0),
            color: bWhite,
            child: state.students.data != null
                ? Column(
                    children: [
                      const Gap(10),
                      TextB(
                        text: state.classInfo,
                        textStyle: bHead6B,
                      ),
                      TextB(
                          text:
                              "Date: ${getDate(value: DateTime.now().toString(), formate: "dd - MMMM, yyyy")}"),
                      const Gap(15),
                      const ScreenHeader(),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          itemCount: state.students.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final date = state.students.data!;
                            return Row(
                              children: [
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
                                            "Roll: ${date[index].admissionNumber!}",
                                        textStyle: bBase2,
                                        fontColor: bGray32,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    bloc.add(ChangeStatus(index: index));
                                  },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: gradient(
                                            date[index].attendanceStatus),
                                      ),
                                    ),
                                    child: TextB(
                                      text: statusText(
                                          date[index].attendanceStatus),
                                      textStyle: bHead6M,
                                      fontColor: bWhite,
                                    ),
                                  ),
                                ),
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

  List<Color> gradient(int status) {
    if (status == 0) {
      return [const Color(0XFFF96F6F), const Color(0XFFB13418)];
    } else if (status == 1) {
      return [const Color(0XFF48DB94), const Color(0XFF069550)];
    } else if (status == 2) {
      return [bGray4, bGray12];
    } else {
      return [const Color(0XFFFFB423), const Color(0XFFF38300)];
    }
  }

  String statusText(int status) {
    if (status == 0) {
      return "A";
    } else if (status == 1) {
      return "P";
    } else if (status == 2) {
      return "L";
    } else {
      return "L.T";
    }
  }
}
