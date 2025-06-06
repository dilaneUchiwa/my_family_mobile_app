import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';

class SelectMembersPage extends StatelessWidget {
  final spaceController = Get.find<SpaceController>();
  final selectedMembers = <int>[].obs;
  final discussionType = Get.arguments['type'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_participants'.tr),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedMembers.isEmpty) {
                ToastController(
                  title: 'Error'.tr,
                  message: 'Please select at least one member'.tr,
                  type: ToastType.error
                ).showToast();
                return;
              }
              // Créer la discussion avec les membres sélectionnés
              Get.back();
            },
            child: Text(
              'done'.tr,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: spaceController.currentSpace.value?.spaceMemberIds.length ?? 0,
        itemBuilder: (context, index) {
          final memberId = spaceController.currentSpace.value!.spaceMemberIds[index];
          return CheckboxListTile(
            value: selectedMembers.contains(memberId),
            onChanged: (selected) {
              if (selected!) {
                selectedMembers.add(memberId);
              } else {
                selectedMembers.remove(memberId);
              }
            },
            title: Text('Member $memberId'), // À remplacer par le nom réel
          );
        },
      )),
    );
  }
}
