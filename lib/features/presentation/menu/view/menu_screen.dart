import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
              const TextB(text: "Menu", textStyle: bHead4B),
              const Gap(20),
              MenuItem(
                name: "Home",
                icon: Icons.home,
                press: () {},
              ),
              MenuItem(
                name: "Profile",
                icon: Icons.person,
                press: () {},
              ),
              MenuItem(
                name: "Settings",
                icon: Icons.settings,
                press: () {},
              ),
              MenuItem(
                name: "Change Language",
                icon: Icons.public,
                press: () {},
              ),
              MenuItem(
                name: "Change Password",
                icon: Icons.lock,
                press: () {},
              ),
              MenuItem(
                name: "Logout",
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
