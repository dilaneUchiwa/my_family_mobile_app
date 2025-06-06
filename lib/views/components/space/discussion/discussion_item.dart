import 'package:flutter/material.dart';
import 'package:my_family_mobile_app/domain/models/space/discussion.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

class DiscussionItem extends StatelessWidget {
  final Discussion discussion;
  final VoidCallback onTap;

  const DiscussionItem({
    required this.discussion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary,
        child: Icon(
          discussion.type == 'P2P' ? Icons.person : Icons.group,
          color: Colors.white,
        ),
      ),
      title: Text(discussion.type),
      subtitle: Text('${discussion.participantIds.length} participants'),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
