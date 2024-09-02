import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/text.dart';

Future<dynamic> openFileBottomSheet(BuildContext context,
    {required Function press}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          color: bWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  press(ImageSource.camera);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: bGreen),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_camera,
                        color: bJungleGreen,
                        size: 35,
                      ),
                      SizedBox(height: 5),
                      TextB(
                        text: "Take Photo",
                        fontColor: bJungleGreen,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 25),
              GestureDetector(
                onTap: () {
                  press(ImageSource.gallery);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: bJungleGreen),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: bJungleGreen,
                        size: 35,
                      ),
                      SizedBox(height: 5),
                      TextB(
                        text: "Select Gallery",
                        fontColor: bJungleGreen,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
