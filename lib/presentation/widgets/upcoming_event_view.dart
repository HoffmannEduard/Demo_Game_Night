import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:demo_game_night/domain/cubits/message_cubit/message_cubit.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/presentation/screens/event_detail_screen.dart';
import 'package:demo_game_night/presentation/widgets/edit_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpcomingEventView extends StatelessWidget {
  final User currentUser;
  const UpcomingEventView({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        if (state is EventInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UpcomingEventLoaded) {
          final events = state.upcomingEvents;
          if (events.isEmpty) {
            return Center(child: Text('Keine bevorstehenden Events.'));
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                child: ListTile(
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(event.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                    ),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gastgeber: ${event.host.firstName} ${event.host.lastName}',
                        style: TextStyle(fontSize: 16),),
                        Text('Datum: ${DateFormat('dd.MM.yyyy - HH:mm').format(event.date)} Uhr',
                        style: TextStyle(fontSize: 16),),
                        Text('(${event.recurrence}-Tage Rhythmus)'),
// Button um Nachricht für das Event zu versenden
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (_) {
                                return BlocProvider.value(
                                  value: context.read<MessageCubit>(),
                                child: EditMessageDialog(
                                  currentUser: currentUser,
                                  event: event,
                                  ),
                                  );
                              });
                          }, 
                          child: Text('Nachricht verfassen'),
                          )
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailScreen(event: event)) 
                          );
                    }, 
                    icon: Icon(Icons.chevron_right)),
                ),
              );
            },
          );
        } else if (state is EventError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Unbekannter Zustand'));
        }
      },
    );
  }
}

