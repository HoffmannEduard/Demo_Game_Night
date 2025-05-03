import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final IEventsRepo _eventsRepo;
  final User currentUser;
  EventCubit(this._eventsRepo, this.currentUser) : super(EventInitial());

  Future<void> loadUpcomingEvents() async {
    emit(EventInitial());
    try {
      final upcomingEvents = await _eventsRepo.getUpcomingEvents(currentUser);
      emit(UpcomingEventLoaded(upcomingEvents));
    } catch (_) {
      emit(EventError('Fehler beim Laden der Events'));
    }
  }

  Future<void> loadPastEvents() async {
    emit(EventInitial());
    try {
      final pastEvents = await _eventsRepo.getPastEvents(currentUser);
      emit(PastEventLoaded(pastEvents));
    } catch (_) {
      emit(EventError('Fehler beim Laden der Events'));
    }
  }
  
}