import 'package:demo_game_night/domain/cubits/create_event_cubit/create_event_cubit.dart';
import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/presentation/widgets/create_event_dialog.dart';
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
                  trailing: context.watch<EventCubit>().hasEventForGroup(g.id) 
// Blendet Icon zum Erstellen von Events aus, wenn bereits ein initiales Event erstellt wurde.
                  ? null : IconButton(
                    onPressed: () {
                      showDialog(
//Gleiches Prinzip wie bei CreateGroupDialog: value(EventCubit) und BlocProvider CreateEventCubit
                        context: context, 
                        builder: (_) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<EventCubit>()
                                ),
                              BlocProvider(
                                create: (_) => CreateEventCubit(
                                  group: g, 
                                  groupRepo: context.read<IGroupRepo>(), 
                                  eventsRepo: context.read<IEventsRepo>()
                                  )
                                )
                            ], 
                            child: CreateEventDialog(group: g));
                        }
                        
                        );
                    },
                    icon: Icon(Icons.calendar_month)),
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