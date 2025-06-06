import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/space/eventController.dart';
import 'package:my_family_mobile_app/controllers/space/spaceController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/domain/models/space/event.dart';

class CreateEventPage extends StatelessWidget {
  final eventController = Get.find<EventController>();
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('create_event'.tr)),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'event_title'.tr),
              validator: (value) => value?.isEmpty ?? true ? 'Required'.tr : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'event_description'.tr),
              minLines: 3,
              maxLines: 5,
              validator: (value) => value?.isEmpty ?? true ? 'Required'.tr : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: startDateController,
              decoration: InputDecoration(labelText: 'event_start_date'.tr),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (date != null) {
                  startDateController.text = DateFormat('yyyy-MM-dd').format(date);
                }
              },
              validator: (value) => value?.isEmpty ?? true ? 'Required'.tr : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: endDateController,
              decoration: InputDecoration(labelText: 'event_end_date'.tr),
              readOnly: true,
              onTap: () async {
                if (startDateController.text.isEmpty) {
                  ToastController(
                    title: 'Error'.tr,
                    message: 'Please select start date first'.tr,
                    type: ToastType.error,
                  ).showToast();
                  return;
                }
                final startDate = DateFormat('yyyy-MM-dd').parse(startDateController.text);
                final date = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: startDate,
                  lastDate: startDate.add(Duration(days: 365)),
                );
                if (date != null) {
                  endDateController.text = DateFormat('yyyy-MM-dd').format(date);
                }
              },
              validator: (value) => value?.isEmpty ?? true ? 'Required'.tr : null,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final event = Event(
                    id: 0,
                    title: titleController.text,
                    description: descriptionController.text,
                    startDate: DateFormat('yyyy-MM-dd').parse(startDateController.text),
                    endDate: DateFormat('yyyy-MM-dd').parse(endDateController.text),
                    spaceId: Get.find<SpaceController>().currentSpace.value!.id,
                    participantsIds: [],
                  );
                  eventController.createEvent(event).then((success) {
                    if (success != null) {
                      Get.back();
                      ToastController(
                        title: 'Success'.tr,
                        message: 'Event created successfully'.tr,
                        type: ToastType.success,
                      ).showToast();
                    }
                  });
                }
              },
              child: Text('create_event'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
