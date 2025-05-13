import 'package:demo_game_night/domain/cubits/create_event_cubit/create_event_cubit.dart';
import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventDialog extends StatelessWidget {
  final Group group;
  final TextEditingController _recurrenceController = TextEditingController();

  CreateEventDialog({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEventCubit, CreateEventState>(
      builder: (context, state) {
        final cubit = context.read<CreateEventCubit>();
        return AlertDialog(
          title: Text('Event erstellen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => cubit.openDatePicker(context),
                child: Text(
                  state.formattedDate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
              TextButton(
                onPressed: () => cubit.openTimePicker(context),
                child: Text(
                  state.formattedTime,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
              Text('Wiederholung:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Alle '),
                    SizedBox(
                      height: 40,
                      width: 60,
                      child: TextField(
                        controller: _recurrenceController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Text(' Tage')
                  ],
                ),
              ),
              if (state.errorMessage != null) // <- Hier wird der Fehler angezeigt
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                state.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            )
            ],
          ),
          // Buttons für das Dialogfenster
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              onPressed: () async {
                final recurrenceText = _recurrenceController.text;
                final success = cubit.setRecurrence(recurrenceText);
                if (!success) return;
                cubit.createInitialEvent();
                await context.read<EventCubit>().loadUpcomingEvents();
              }, 
              child: Text('Erstellen')
              )
          ],
        );
      },
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event erfolgreich erstellt'))
            );
        }
      },
    );
  }
}
