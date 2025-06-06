import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';

class SpaceSettingsPage extends StatelessWidget {
  final spaceController = Get.find<SpaceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('space_settings'.tr)),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.group),
            title: Text('space_members'.tr),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Get.toNamed(AppRoutes.spaceMembers),
          ),
          // Autres paramètres à ajouter
        ],
      ),
    );
  }
}
