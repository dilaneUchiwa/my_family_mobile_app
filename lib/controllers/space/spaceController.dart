import 'package:get/get.dart';
import 'package:my_family_mobile_app/domain/models/space/space.dart';
import 'package:my_family_mobile_app/services/spaceService.dart';

class SpaceController extends GetxController {
  var spaces = <Space>[].obs;
  var isLoading = false.obs;
  var currentSpace = Rxn<Space>();

  @override
  void onInit() {
    super.onInit();
    fetchSpaces();
  }

  Future<void> fetchSpaces() async {
    isLoading.value = true;
    try {
      spaces.value = await SpaceService.getSpaces();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createSpace(Space space) async {
    isLoading.value = true;
    try {
      final createdSpace = await SpaceService.createSpace(space);
      if (createdSpace != null) {
        spaces.add(createdSpace);
        return true;
      }
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void selectSpace(Space space) {
    currentSpace.value = space;
  }

  Future<void> onRefresh() async {
    await fetchSpaces();
  }
}
