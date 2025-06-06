import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/domain/models/space/event.dart';
import 'package:my_family_mobile_app/services/space/eventService.dart';

class EventController extends GetxController {
  var events = <Event>[].obs;
  var currentEvent = Rxn<Event>();
  var isLoading = false.obs;

  Future<void> fetchSpaceEvents(int spaceId) async {
    isLoading.value = true;
    try {
      events.value = await EventService.getSpaceEvents(spaceId);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Event?> createEvent(Event event) async {
    isLoading.value = true;
    try {
      final createdEvent = await EventService.createEvent(event);
      if (createdEvent != null) {
        events.add(createdEvent);
        currentEvent.value = createdEvent;
      }
      return createdEvent;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addParticipant(int nodeId) async {
    if (currentEvent.value == null) return false;
    final result = await EventService.addParticipant(currentEvent.value!.id, nodeId);
    if (result != null) {
      currentEvent.value = result;
      return true;
    }
    return false;
  }

  Future<bool> removeParticipant(int nodeId) async {
    if (currentEvent.value == null) return false;
    final result = await EventService.removeParticipant(currentEvent.value!.id, nodeId);
    if (result != null) {
      currentEvent.value = result;
      return true;
    }
    return false;
  }

  Future<void> onRefresh() async {
    if (currentEvent.value != null) {
      final event = await EventService.getEvent(currentEvent.value!.id);
      if (event != null) {
        currentEvent.value = event;
      }
    }
  }

  Future<void> refreshEventList() async {
    final spaceId = Get.find<SpaceController>().currentSpace.value?.id;
    if (spaceId != null) {
      await fetchSpaceEvents(spaceId);
    }
  }
}
