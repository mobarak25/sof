import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class FutureAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isDashboard;
  final bool fromNotificationScreen;
  final String version;
  final bool isLoading;

  const FutureAppBar({
    super.key,
    required this.title,
    this.actions = const [SizedBox()],
    this.isLoading = false,
    this.isDashboard = false,
    this.fromNotificationScreen = false,
    this.version = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: bPrimaryColor,
      ),
      title: isDashboard
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/classtune_app_bar_logo.png',
                      width: 100,
                      height: 90,
                    ),
                    const Gap(10),
                    TextB(
                      text: "v$version",
                      textStyle: bCaption2B,
                      fontColor: bBlack,
                    ),
                  ],
                ),
                const FutureNotification()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 42),
                    child: TextB(
                      text: title,
                      textStyle: bBody1M,
                      alignMent: TextAlign.center,
                    ),
                  ),
                ),
                !fromNotificationScreen
                    ? const FutureNotification()
                    : const SizedBox(
                        height: 30,
                        width: 30,
                      ),
              ],
            ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: bGray12,
          height: 1.5,
          child: isLoading
              ? const LinearProgressIndicator(color: kPrimaryColor)
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class FutureNotification extends StatelessWidget {
  const FutureNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context, rootNavigator: true).pushNamed(kNotificationScreen);
      },
      child: const SizedBox(
        height: 30,
        width: 30,
        child: Icon(
          Icons.notifications,
        ),
      ),
    );
  }
}
