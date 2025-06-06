import 'package:flutter/material.dart';
import 'package:my_family_mobile_app/domain/models/space/space.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

class SpaceCard extends StatelessWidget {
  final Space space;
  final VoidCallback onTap;

  const SpaceCard({
    required this.space,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            space.id.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text('Space ${space.id}'),
        subtitle: Text('Members: ${space.spaceMemberIds.length}'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
