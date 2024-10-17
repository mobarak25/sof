import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';

import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/transport/transport/bloc/transport_bloc.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TransportBloc, TransportState>(
      builder: (context, state) {
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.transport.tr(),
          ),
          child: Container(
            color: bInnerBg,
            child: state.transport.data != null
                ? ListView(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: size.height * 0.4,
                            child: Image.asset(
                              'assets/images/transport_image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 25,
                              decoration: const BoxDecoration(
                                color: bWhite,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      ...List.generate(
                        state.transport.data!.schedules!.length,
                        (index) {
                          final data = state.transport.data!;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            decoration: const BoxDecoration(
                              color: bWhite,
                              border: Border(
                                bottom: BorderSide(color: bGray12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextB(
                                  text: data.schedules![index].weekday!,
                                  textStyle: bSub1,
                                  fontColor: bGray100,
                                ),
                                const Gap(12),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 35),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextB(
                                                text: LocaleKeys.pFrmHome.tr(),
                                                textStyle: bBase2,
                                                fontColor: bGray52,
                                              ),
                                              TextB(
                                                text: data.schedules![index]
                                                    .homePickupTime!,
                                                textStyle: bBody2M,
                                                fontColor: bGray100,
                                              ),
                                            ],
                                          ),
                                          const Gap(25),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextB(
                                                text:
                                                    LocaleKeys.pFrmSchool.tr(),
                                                textStyle: bBase2,
                                                fontColor: bGray52,
                                              ),
                                              TextB(
                                                text: data.schedules![index]
                                                    .schoolPickupTime!,
                                                textStyle: bBody2M,
                                                fontColor: bGray100,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 1,
                                        color: data.schedules![index].isToday!
                                            ? bJungleGreen
                                            : bGray,
                                      ),
                                    ),
                                    Positioned(
                                        left: 0,
                                        top: 0,
                                        child: pointer(
                                          true,
                                          data.schedules![index].isToday!,
                                        )),
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: pointer(
                                        false,
                                        data.schedules![index].isToday!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Gap(90),
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

  Container pointer(bool isTop, bool isToday) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isTop && isToday
            ? bJungleGreen
            : isToday
                ? kSecondaryColor
                : bGray32,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.location_on,
        size: 15,
        color: bWhite,
      ),
    );
  }
}
