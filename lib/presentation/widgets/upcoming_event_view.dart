import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingEventView extends StatelessWidget {
  const UpcomingEventView({super.key});

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
                  title: Text('Abend bei ${event.host.firstName}'),
                  subtitle: Text('Datum: ${event.date}'),
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
