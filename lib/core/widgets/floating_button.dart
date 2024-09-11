import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key, required this.press});

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 15,
      child: InkWell(
        onTap: () {
          press();
        },
        child: Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            size: 30,
            color: bWhite,
          ),
        ),
      ),
    );
  }
}
