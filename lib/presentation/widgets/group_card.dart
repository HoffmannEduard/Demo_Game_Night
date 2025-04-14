import 'package:demo_game_night/domain/entities/group.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final Group group;
  
  const GroupCard({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(group.name),
        onTap: () {
          // Zeigt die Mitglieder der Gruppe in einem Dialog an
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Mitglieder von ${group.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: group.members
                    .map((user) => ListTile(
                          title: Text('${user.firstName} ${user.lastName}'),
                          subtitle: Text('@${user.username}'),
                        ))
                    .toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Schließen'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
