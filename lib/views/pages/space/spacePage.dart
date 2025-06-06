import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/views/components/space/space_card.dart';

class SpacePage extends StatelessWidget {
  final spaceController = Get.put(SpaceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('space'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed(AppRoutes.spaceCreate),
          ),
        ],
      ),
      body: Obx(() => spaceController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => spaceController.onRefresh(),
              child: spaceController.spaces.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(height: Get.height * 0.3),
                        Center(
                          child: Column(
                            children: [
                              Icon(Icons.space_dashboard_outlined, size: 50, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('no_spaces'.tr, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: spaceController.spaces.length,
                      itemBuilder: (context, index) => SpaceCard(
                        space: spaceController.spaces[index],
                        onTap: () {
                          spaceController.selectSpace(spaceController.spaces[index]);
                          Get.toNamed(AppRoutes.spaceDetails);
                        },
                      ),
                    ),
            )),
    );
  }
}
