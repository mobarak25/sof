import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    this.child,
    this.isFullScreen = false,
    this.horizontalPadding = 15,
    this.bottomNav,
    this.appBar,
  });

  final Widget? child;
  final bool isFullScreen;
  final double horizontalPadding;
  final Widget? bottomNav;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
          top: isFullScreen ? 0 : MediaQuery.of(context).padding.top,
          bottom: isFullScreen ? 0 : MediaQuery.of(context).padding.bottom,
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
