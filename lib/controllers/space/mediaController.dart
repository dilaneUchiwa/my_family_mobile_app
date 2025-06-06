import 'package:get/get.dart';
import 'package:my_family_mobile_app/domain/models/space/media.dart';
import 'package:my_family_mobile_app/services/space/mediaService.dart';

class MediaController extends GetxController {
  var medias = <Media>[].obs;
  var currentMedia = Rxn<Media>();
  var isLoading = false.obs;

  Future<Media?> uploadMedia(int messageId, String path, String type) async {
    isLoading.value = true;
    try {
      final media = await MediaService.createMedia(messageId, path, type);
      if (media != null) {
        medias.add(media);
        currentMedia.value = media;
      }
      return media;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Media>> getMessageMedias(int messageId) async {
    isLoading.value = true;
    try {
      final messageMedias = await MediaService.getMessageMedias(messageId);
      medias.assignAll(messageMedias);
      return messageMedias;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteMedia(int mediaId) async {
    isLoading.value = true;
    try {
      final success = await MediaService.deleteMedia(mediaId);
      if (success) {
        medias.removeWhere((media) => media.id == mediaId);
      }
      return success;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteMessageMedias(int messageId) async {
    isLoading.value = true;
    try {
      final success = await MediaService.deleteMessageMedias(messageId);
      if (success) {
        medias.removeWhere((media) => media.messageId == messageId);
      }
      return success;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    if (currentMedia.value != null) {
      await getMessageMedias(currentMedia.value!.messageId);
    }
  }
}
