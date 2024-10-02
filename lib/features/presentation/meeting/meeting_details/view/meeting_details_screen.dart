import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/detail_description.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_details/bloc/meeting_details_bloc.dart';

class MeetingDetailsScreen extends StatelessWidget {
  const MeetingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingDetailsBloc, MeetingDetailsState>(
      builder: (context, state) {
        final bloc = context.read<MeetingDetailsBloc>();
        final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.meetingDetails.tr(),
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
                          TextB(
                            text: data.title ?? '',
                            textStyle: bHead6B,
                            fontColor: bGray100,
                            alignMent: TextAlign.center,
                          ),
                          const Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextB(
                                text: "Meeting Type: ",
                                textStyle: bSub2,
                                fontColor: bGray52,
                              ),
                              TextB(
                                text: data.meetingType == 1
                                    ? 'Online'
                                    : "Offline",
                                textStyle: bSub2,
                                fontColor: kPrimaryColor,
                              ),
                            ],
                          ),
                          const Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextB(
                                text: "Date: ",
                                textStyle: bSub2,
                                fontColor: bGray52,
                              ),
                              TextB(
                                text: getDate(
                                    value: data.date!,
                                    formate: "dd-MMMM, yyyy"),
                                textStyle: bSub2,
                                fontColor: kPrimaryColor,
                              ),
                            ],
                          ),
                          const Gap(40),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            color: kSecondaryColor.withOpacity(0.05),
                            child: TextB(
                              text: "${data.startTime} - ${data.endTime}",
                              textStyle: bHead6M,
                              fontColor: kSecondaryColor,
                              alignMent: TextAlign.center,
                            ),
                          ),
                          const Gap(15),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: bGray12,
                          ),
                          const Gap(20),
                          const TextB(
                            text: "Meeting Link",
                            textStyle: bBody1M,
                            fontColor: bGray100,
                          ),
                          const Gap(5),
                          TextB(
                            text: data.meetingLink ?? '',
                            textStyle: bBody2,
                            fontColor: kPrimaryColor,
                            maxLines: 1,
                          ),
                          const Gap(40),
                          const TextB(
                            text: "Meeting With",
                            textStyle: bBody1M,
                            fontColor: bGray100,
                          ),
                          const Gap(5),
                          Row(
                            children: [
                              const TextB(
                                text: 'Attendee: ',
                                textStyle: bBody2,
                                maxLines: 1,
                              ),
                              Flexible(
                                child: TextB(
                                  text: data.meetingMembers!.name ?? '',
                                  textStyle: bBody2,
                                  fontColor: kPrimaryColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  bloc.add(OpenListDialog());
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: bWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                          color: bBlack.withOpacity(0.15),
                                        )
                                      ]),
                                  width: 50,
                                  height: 50,
                                  child: TextB(
                                    text: "+${data.meetingMembers!.more!}",
                                    textStyle: bBase2,
                                    fontColor: kPrimaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Gap(40),
                          DetailDescription(
                            customTitleTextStyle: bBody1M,
                            description: data.description ?? '',
                            attachments: const [],
                          ),
                          const Gap(40),
                          const TextB(
                            text: "Agenda",
                            textStyle: bBody1M,
                            fontColor: bGray100,
                          ),
                          const Gap(5),
                          ...List.generate(
                            data.agenda!.length,
                            (index) => TextB(
                                text:
                                    "${index + 1}. ${data.agenda![index].title!}"),
                          ),
                          const Gap(10),
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
                            // bloc.add(PressToDelEdit(id: data.id!, type: value));
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
