import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/space/eventController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';

class EventDetailsPage extends StatelessWidget {
  final eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(eventController.currentEvent.value?.title ?? '')),
      ),
      body: Obx(() => eventController.currentEvent.value == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventController.currentEvent.value!.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    eventController.currentEvent.value!.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'event_details'.tr,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 8),
                              Text(
                                'Start: ${DateFormat('dd/MM/yyyy').format(eventController.currentEvent.value!.startDate)}',
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 8),
                              Text(
                                'End: ${DateFormat('dd/MM/yyyy').format(eventController.currentEvent.value!.endDate)}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'event_participants'.tr,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              IconButton(
                                icon: Icon(Icons.person_add),
                                onPressed: () => Get.toNamed(AppRoutes.discussionSelectMembers),
                              ),
                            ],
                          ),
                          Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: eventController.currentEvent.value?.participantsIds.length ?? 0,
                            itemBuilder: (context, index) {
                              final participantId = eventController.currentEvent.value!.participantsIds[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(participantId.toString()),
                                ),
                                title: Text('Participant $participantId'),
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () => eventController.removeParticipant(participantId),
                                ),
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
