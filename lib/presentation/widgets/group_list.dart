import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupLoaded) {
          return ListView(
            children: state.groups.map((g) { 
              return GestureDetector(
                onTap: () => 
                  _showGroupMembers(context, g),
                child: Card(
                  child: ListTile(title: Text(g.name),
                        )
                  ),
              );
        }).toList(),
          );
        } else if (state is! GroupLoaded){
          return Center(child: Text('State ist $state'),);
        }
        return SizedBox();
      }
      );
  }
  void _showGroupMembers(BuildContext context, Group group) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mitglieder der Gruppe: ${group.name}'),
          content: SingleChildScrollView(
            child: Column(
              children: group.members.map((user) {
                return ListTile(
                  title: Text(user.username), // Der Name des Mitglieds
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Schließen'),
            ),
          ],
        );
      },
    );
  }
}