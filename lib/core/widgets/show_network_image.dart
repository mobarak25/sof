import 'package:flutter/material.dart';
import 'package:school_of_future/core/widgets/network_image.dart';

Future showNetworkImage(BuildContext context, {required String imageUrl}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(8),
        content: NetWorkImageViewB(
          imageUrl: imageUrl,
        ),
      );
    },
  );
}
