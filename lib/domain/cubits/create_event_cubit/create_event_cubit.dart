import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_event_state.dart';

class CreateEventCubit extends Cubit<CreateEventState> {
  final Group group;
  final IGroupRepo groupRepo;
  final IEventsRepo eventsRepo;

  CreateEventCubit({required this.group, required this.groupRepo, required this.eventsRepo}) : super(CreateEventState());


void selectDate(DateTime date) {
  emit(state.copyWith(selectedDate: date));
}

void selectTime(TimeOfDay time) {
  emit(state.copyWith(selectedTime: time));
}

bool setRecurrence(String recurrenceText) {
  final recurrence = int.tryParse(recurrenceText);
  if (recurrence == null || recurrence < 1 || recurrence >400) {
    emit(state.copyWith(errorMessage: "Bitte Zahl zwischen 1 und 400 eingeben"));
    return false;
  }
  emit(state.copyWith(recurrence: recurrence, errorMessage: null));
  return true;
}

Future<void> openDatePicker(BuildContext context) async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), 
    firstDate: DateTime.now(), 
    lastDate: DateTime(2100)
    );

    if (date != null) selectDate(date);
}

Future<void> openTimePicker(BuildContext context) async {
  final time = await showTimePicker(
    context: context, 
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
    );

    if (time != null) selectTime(time);
}

Future<void> createInitialEvent() async {
  if (state.selectedDate == null || state.selectedTime == null) {
    emit(state.copyWith(errorMessage: 'Bitte alle Felder ausfüllen'));
    return;
  }

  emit(state.copyWith(errorMessage: null));
  final DateTime combinedDateTime = DateTime(
  state.selectedDate!.year,
  state.selectedDate!.month,
  state.selectedDate!.day,
  state.selectedTime!.hour,
  state.selectedTime!.minute,
); 
  final newEvent = GameNightEvent(
    id: DateTime.now().microsecondsSinceEpoch, 
    name: group.name, 
    groupId: group.id, 
    host: group.members.first, 
    date: combinedDateTime, 
    recurrence: state.recurrence!, 
    isPast: false, 
  );

    await eventsRepo.createEvent(newEvent);
    emit(state.copyWith(isSuccess: true));
}

}
