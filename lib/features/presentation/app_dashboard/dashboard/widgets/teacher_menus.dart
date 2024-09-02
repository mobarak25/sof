import 'package:flutter/material.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TeacherMenus extends StatelessWidget {
  const TeacherMenus({
    super.key,
    required this.panelController,
  });

  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            panelController.close();
            navigatorKey.currentState!
                .pushNamedAndRemoveUntil(studentHome, ModalRoute.withName('/'));
          },
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Search'),
          onTap: () {
            panelController.close();
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                studentSearch, ModalRoute.withName('/'));
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('TProfile'),
          onTap: () {
            if (panelController.isPanelOpen) {
              panelController.close();
            }
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                teacherProfile, ModalRoute.withName('/'));
          },
        ),
      ],
    );
  }
}
