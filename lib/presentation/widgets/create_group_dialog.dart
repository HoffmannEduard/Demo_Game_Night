import 'package:demo_game_night/domain/cubits/create_group_cubit/create_group_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroupDialog extends StatelessWidget {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  CreateGroupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateGroupCubit, CreateGroupState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // Nach erfolgreicher Erstellung Gruppen neu laden + Dialog schließen
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gruppe erfolgreich erstellt!')),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Neue Gruppe erstellen'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Gruppenname
                TextField(
                  controller: _groupNameController,
                  decoration: InputDecoration(labelText: 'Gruppenname'),
                ),
                const SizedBox(height: 16),

                // User hinzufügen
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: 'Mitglied hinzufügen'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final username = _usernameController.text.trim();
                        if (username.isNotEmpty) {
                          context.read<CreateGroupCubit>().tryAddMember(username);
                          _usernameController.clear();
                        }
                      },
                    ),
                  ],
                ),

                if (state.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],

                const SizedBox(height: 16),

                // Liste hinzugefügter Mitglieder
                if (state.members.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.members.map((user) {
                      return ListTile(
                        title: Text(user.username),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<CreateGroupCubit>().removeMember(user);
                          },
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () async {
                final groupName = _groupNameController.text.trim();
                context.read<CreateGroupCubit>().updateGroupName(groupName);
                context.read<CreateGroupCubit>().createGroup();
                await context.read<GroupCubit>().loadGroups();
              },
              child: const Text('Erstellen'),
            ),
          ],
        );
      },
    );
  }
}
