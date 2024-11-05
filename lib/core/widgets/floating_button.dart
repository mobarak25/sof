import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton(
      {super.key, required this.press, this.bottom, this.icon});

  final VoidCallback press;
  final double? bottom;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom ?? 100,
      right: 15,
      child: Material(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () {
            press();
          },
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: icon ??
                const Icon(
                  Icons.add,
                  size: 30,
                  color: bWhite,
                ),
          ),
        ),
      ),
    );
  }
}
