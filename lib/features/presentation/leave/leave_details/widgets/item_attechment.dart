import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class ItemAttachment extends StatelessWidget {
  final String text;
  final Function() action;
  final Function() downloadRequest;

  const ItemAttachment(
      {super.key,
      required this.text,
      required this.action,
      required this.downloadRequest});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: Icon(
                          Icons.attach_file,
                          color: bJungleGreen,
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextB(
                        text: text,
                        textStyle: bBody2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                downloadRequest();
              },
              child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.download_sharp,
                    color: bJungleGreen,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
