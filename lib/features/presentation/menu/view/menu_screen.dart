import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/menu/bloc/menu_bloc.dart';
import 'package:school_of_future/features/presentation/menu/widgets/menu_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        final bloc = context.read<MenuBloc>();
        return Body(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, size: 45),
                  ),
                ],
              ),
              const Gap(10),
              TextB(text: "Menu".tr(), textStyle: bHead4B),
              const Gap(20),
              MenuItem(
                name: "Home".tr(),
                icon: Icons.home,
                press: () {
                  Navigator.pop(context);
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                },
              ),
              MenuItem(
                name: "Profile".tr(),
                icon: Icons.person,
                press: () {
                  Navigator.pop(context);
                  if (state.isTeacher) {
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        teacherProfile, ModalRoute.withName('/'));
                  } else {
                    navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        studentProfile, ModalRoute.withName('/'));
                  }
                },
              ),
              MenuItem(
                name: "Settings".tr(),
                icon: Icons.settings,
                press: () {},
              ),
              MenuItem(
                name: "Change Language".tr(),
                icon: Icons.public,
                press: () {
                  bloc.add(ChangeLanguage(context: context));
                },
              ),
              MenuItem(
                name: "Change Password".tr(),
                icon: Icons.lock,
                press: () {
                  Navigator.pushNamed(context, changePassword);
                },
              ),
              MenuItem(
                name: "Logout".tr(),
                icon: Icons.logout,
                press: () {
                  bloc.add(LogOut());
                },
                color: bRed,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: size.width * 0.6,
                      child: Image.asset(classtuneLogo)),
                ],
              ),
              const Gap(15),
            ],
          ),
        );
      },
    );
  }
}
