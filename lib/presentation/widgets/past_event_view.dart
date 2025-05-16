import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          return Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(event.name,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                            ),
                          ),
                          Text('Gastgeber: ${event.host.firstName} ${event.host.lastName}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
                          ),
                          const SizedBox(height: 4,),
                          Text('Datum: ${DateFormat('dd.MM.yyyy - HH:mm').format(event.date)} Uhr',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
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
            ),
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
