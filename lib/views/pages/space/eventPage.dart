import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/space/eventController.dart';
import 'package:my_family_mobile_app/domain/models/space/event.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

class EventPage extends StatelessWidget {
  final eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('events'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.toNamed(AppRoutes.eventCreate),
          ),
        ],
      ),
      body: Obx(() => eventController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => eventController.refreshEventList(),
              child: eventController.events.isEmpty
                  ? ListView(
                      children: [
                        SizedBox(height: Get.height * 0.3),
                        Center(
                          child: Column(
                            children: [
                              Icon(Icons.event_busy, size: 50, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('no_events_yet'.tr, style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: eventController.events.length,
                      itemBuilder: (context, index) {
                        final event = eventController.events[index];
                        return EventCard(
                          event: event,
                          onTap: () {
                            eventController.currentEvent.value = event;
                            Get.toNamed(AppRoutes.eventDetails);
                          },
                        );
                      },
                    ),
            )),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.event, color: Colors.white),
        ),
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description),
            Text(
              '${DateFormat('dd/MM/yyyy').format(event.startDate)} - ${DateFormat('dd/MM/yyyy').format(event.endDate)}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${event.participantsIds.length}'),
            Icon(Icons.people),
          ],
        ),
      ),
    );
  }
}
