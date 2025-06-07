import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/domain/models/node_relation.dart';
import 'package:my_family_mobile_app/services/nodeService.dart';
import 'package:popover/popover.dart';
import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/utils/appImages.dart';

class FamilyNodeWidget extends StatelessWidget {
  final BaseNode node;
  final String relation;

  const FamilyNodeWidget({
    required this.node,
    required this.relation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showNodeDetails(context),
      child: Container(
        width: 90,
        constraints: const BoxConstraints(maxHeight: 120),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Important: force column to minimum size
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getBorderColor(),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(AppImages.avatar),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 90,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '${node.firstName}\n${node.lastName}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNodeDetails(BuildContext context) {
    showPopover(
      context: context,
      bodyBuilder: (context) => _NodeDetailsPopover(node: node, relation: relation),
      direction: PopoverDirection.bottom,
      width: 300,
      arrowHeight: 15,
      arrowWidth: 30,
    );
  }

  Color _getBorderColor() {
    switch (node.gender) {
      case 'MALE':
        return Colors.blue;
      case 'FEMALE':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}

class _NodeDetailsPopover extends StatelessWidget {
  final BaseNode node;
  final String relation;

  const _NodeDetailsPopover({
    required this.node,
    required this.relation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      constraints: BoxConstraints(maxWidth: 300), // Ajout d'une contrainte de largeur maximale
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // Force la Row à se rétrécir
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible( // Remplace Expanded par Flexible
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(AppImages.avatar),
                    ),
                    SizedBox(width: 12),
                    Flexible( // Utilise Flexible ici aussi
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${node.title} ${node.firstName} ${node.lastName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            relation,
                            style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () => _showAddRelationDialog(context),
                tooltip: 'add_relation'.tr,
              ),
            ],
          ),
          SizedBox(height: 16),
          _InfoRow(icon: Icons.cake, text: 'member.birth_date'.tr + ': ' + node.birthDate.toString().split(' ')[0]),
          _InfoRow(icon: Icons.phone, text: 'member.phone'.tr + ': ' + node.phone),
          _InfoRow(icon: Icons.location_on, text: 'member.address'.tr + ': ' + node.address),
          if (node.interests.isNotEmpty) ...[
            SizedBox(height: 8),
            Text('member.interests'.tr),
            Wrap(
              spacing: 4,
              children: node.interests.map((interest) => Chip(
                label: Text(interest),
                backgroundColor: Colors.blue.withOpacity(0.1),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddRelationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddRelationDialog(sourceNode: node),
    );
  }
}

class AddRelationDialog extends StatefulWidget {
  final BaseNode sourceNode;

  const AddRelationDialog({required this.sourceNode});

  @override
  State<AddRelationDialog> createState() => _AddRelationDialogState();
}

class _AddRelationDialogState extends State<AddRelationDialog> {
  RelationType? selectedRelationType;
  final _formKey = GlobalKey<FormState>();
  
  final titleController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final interestsController = TextEditingController();
  
  String selectedGender = 'MALE';
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('add_relation'.tr),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<RelationType>(
                value: selectedRelationType,
                decoration: InputDecoration(labelText: 'relation_type'.tr),
                items: RelationType.values.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text('relation.${type.toString().split('.').last.toLowerCase()}'.tr),
                )).toList(),
                onChanged: (value) => setState(() => selectedRelationType = value),
                validator: (value) => value == null ? 'required'.tr : null,
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'title'.tr),
                validator: (value) => value?.isEmpty ?? true ? 'required'.tr : null,
              ),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'first_name'.tr),
                validator: (value) => value?.isEmpty ?? true ? 'required'.tr : null,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'last_name'.tr),
                validator: (value) => value?.isEmpty ?? true ? 'required'.tr : null,
              ),
              ListTile(
                title: Text('birth_date'.tr),
                subtitle: Text(selectedDate.toString().split(' ')[0]),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(labelText: 'gender'.tr),
                items: ['MALE', 'FEMALE', 'OTHER'].map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text('gender.${gender.toLowerCase()}'.tr),
                )).toList(),
                onChanged: (value) => setState(() => selectedGender = value!),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'address'.tr),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'phone'.tr),
              ),
              TextFormField(
                controller: interestsController,
                decoration: InputDecoration(
                  labelText: 'interests'.tr,
                  helperText: 'separate_by_comma'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancel'.tr),
        ),
        ElevatedButton(
          onPressed: _createRelation,
          child: Text('create'.tr),
        ),
      ],
    );
  }

  Future<void> _createRelation() async {

    await _showInvitationCodeDialog(1);

    return;

    if (!_formKey.currentState!.validate()) return;

    final nodeData = {
      'title': titleController.text,
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'birthDate': selectedDate.toIso8601String().split('T')[0],
      'gender': selectedGender,
      'address': addressController.text,
      'phone': phoneController.text,
      'interests': interestsController.text.split(',').map((e) => e.trim()).toList(),
      'relationType': selectedRelationType.toString().split('.').last,
      'relatedNodeId': widget.sourceNode.id,
      'baseNode': false
    };

    try {
      final newNode = await NodeService.createNode(nodeData);
      if (newNode != null) {
        Get.find<Homecontroller>().buildFamilyGraph();
        await _showInvitationCodeDialog(newNode.id);
        Navigator.pop(context);
        ToastController(
          title: 'success'.tr,
          message: 'relation_created'.tr,
          type: ToastType.success
        ).showToast();
      }
    } catch (e) {
      ToastController(
        title: 'error'.tr,
        message: 'error_creating_relation'.tr,
        type: ToastType.error
      ).showToast();
    }
  }

  Future<void> _showInvitationCodeDialog(int nodeId) async {
    try {
      // final invitationCode = await NodeService.generateInvitationCode(nodeId);
      final invitationCode = "946845";
      if (invitationCode != null) {
        await Get.dialog(
          AlertDialog(
            title: Text('invitation_code_title'.tr),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('invitation_code_description'.tr),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        invitationCode,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: invitationCode));
                          ToastController(
                            title: 'success'.tr,
                            message: 'code_copied'.tr,
                            type: ToastType.success
                          ).showToast();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('close'.tr),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      ErrorController.handleError(e);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    interestsController.dispose();
    super.dispose();
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}