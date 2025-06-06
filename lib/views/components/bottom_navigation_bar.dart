import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/themes/theme.dart';
import 'package:my_family_mobile_app/utils/appImages.dart';
import 'package:my_family_mobile_app/views/components/svg_icon.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  BottomNavigationBarComponent({super.key});

  final homeController = Get.find<Homecontroller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: SizedBox(
        height: 60,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(
              () => Row(
                children: [
                  _BottomItem(
                    icon: AppImages.home,
                    title: 'home'.tr,
                    currentIndex: homeController.selectedNavIndex.value,
                    index: 0,
                    onTap: homeController.selectedNavIndex,
                    size: 30,
                  ),
                  _BottomItem(
                    icon: AppImages.home,
                    title: 'space'.tr,
                    currentIndex: homeController.selectedNavIndex.value,
                    index: 1,
                    onTap: homeController.selectedNavIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    super.key,
    required this.icon,
    required this.title,
    required this.currentIndex,
    required this.index,
    required this.onTap,
    this.activeIcon,
    this.size,
  });

  final int currentIndex;
  final int index;
  final String icon;
  final String? activeIcon;
  final String title;
  final ValueSetter<int> onTap;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: SvgIcon(
                (isSelected ? (activeIcon ?? icon) : icon),
                color: isSelected ? AppColors.primary : null,
                width: isSelected ? (size != null ? size! + 3.0 : 30) : size,
                height: isSelected ? (size != null ? size! + 3.0 : 30) : size,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
                  color: isSelected ? AppColors.primary : null),
            )
          ],
        ),
      ),
    );
  }
}
