import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';

class CreateSpacePage extends StatelessWidget {
  final spaceController = Get.find<SpaceController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create_space'.tr)),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Form fields will be added here
            ],
          ),
        ),
      ),
    );
  }
}
