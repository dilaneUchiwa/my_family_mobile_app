import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        constraints: BoxConstraints(maxHeight: 120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(height: 4),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  '${node.firstName}\n${node.lastName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(AppImages.avatar),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${node.title} ${node.firstName} ${node.lastName}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      relation,
                      style: TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
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