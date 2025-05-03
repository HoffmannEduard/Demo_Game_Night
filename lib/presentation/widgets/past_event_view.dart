import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PastEventView extends StatelessWidget {
  const PastEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        if (state is EventInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PastEventLoaded) {
          final events = state.pastEvents;
          if (events.isEmpty) {
            return Center(child: Text('Keine bevorstehenden Events.'));
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bewertung: \nAbend bei ${event.host.firstName}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4,),
                        Text('vom ${event.date}'),
                        const SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amberAccent,
                                foregroundColor: Colors.black
                              ),
                              child: Text('Bewerten')),
                          ],
                        )
                      ],
                    ),
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
