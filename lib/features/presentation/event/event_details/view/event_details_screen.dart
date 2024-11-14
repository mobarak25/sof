import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/detail_description.dart';
import 'package:school_of_future/features/presentation/event/event_details/bloc/event_details_bloc.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, EventDetailsState>(
      builder: (context, state) {
        final bloc = context.read<EventDetailsBloc>();
        final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.academicCalendar.tr(),
          ),
          child: data != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
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
                              child: SvgPicture.asset(
                                "assets/images/feature_icons_svg/icon_digital_rep_inner.svg",
                                colorFilter: const ColorFilter.mode(
                                    kPrimaryColor, BlendMode.srcIn),
                              ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      DetailDescription(
                        description: data.description ?? '',
                        attachments: data.eventFile != null
                            ? data.eventFile!.map((e) => e.url).toList()
                            : [],
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
