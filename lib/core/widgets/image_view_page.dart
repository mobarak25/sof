import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;

  const ImageViewerScreen({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FutureAppBar(title: LocaleKeys.attachment.tr()),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: LimitedBox(child: Image.network(imageUrl)),
      ),
    );
  }
}
