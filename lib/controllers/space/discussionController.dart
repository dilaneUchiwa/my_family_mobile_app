import 'package:get/get.dart';
import 'package:my_family_mobile_app/domain/models/space/discussion.dart';
import 'package:my_family_mobile_app/services/space/discussionService.dart';

class DiscussionController extends GetxController {
  var discussions = <Discussion>[].obs;
  var currentDiscussion = Rxn<Discussion>();
  var isLoading = false.obs;

  Future<void> fetchSpaceDiscussions(int spaceId) async {
    isLoading.value = true;
    try {
      discussions.value = await DiscussionService.getSpaceDiscussions(spaceId);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Discussion?> createP2PDiscussion(int spaceId, List<int> participants) async {
    isLoading.value = true;
    try {
      final discussion = await DiscussionService.createP2PDiscussion(spaceId, participants);
      if (discussion != null) {
        discussions.add(discussion);
        currentDiscussion.value = discussion;
      }
      return discussion;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectDiscussion(int discussionId) async {
    isLoading.value = true;
    try {
      final discussion = await DiscussionService.getDiscussion(discussionId);
      if (discussion != null) {
        currentDiscussion.value = discussion;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addParticipant(int nodeId) async {
    if (currentDiscussion.value == null) return false;
    
    final success = await DiscussionService.addParticipant(
      currentDiscussion.value!.id,
      nodeId
    );
    
    if (success) {
      await refreshCurrentDiscussion();
    }
    
    return success;
  }

  Future<void> refreshCurrentDiscussion() async {
    if (currentDiscussion.value != null) {
      final updatedDiscussion = await DiscussionService.getDiscussion(
        currentDiscussion.value!.id
      );
      if (updatedDiscussion != null) {
        currentDiscussion.value = updatedDiscussion;
      }
    }
  }
}
