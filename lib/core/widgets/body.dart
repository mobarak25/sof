import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    this.child,
    this.drawerChild,
    this.isFullScreen = false,
    this.horizontalPadding = 15,
    this.bottomNav,
    this.appBar,
  });

  final Widget? child;
  final Widget? drawerChild;
  final bool isFullScreen;
  final double horizontalPadding;
  final Widget? bottomNav;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScaffoldBGColor,
      appBar: appBar,
      endDrawer: drawerChild != null ? Drawer(child: drawerChild) : null,
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          left: isFullScreen ? 0 : horizontalPadding,
          right: isFullScreen ? 0 : horizontalPadding,
        ),
        child: Column(
          children: [
            Expanded(child: child!),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav,
    );
  }
}
