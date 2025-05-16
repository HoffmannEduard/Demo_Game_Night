import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final IEventsRepo _eventsRepo;
  final IGroupRepo _groupRepo;
  final User currentUser;
  List<GameNightEvent> _upcomingEvents = [];

  EventCubit(this._eventsRepo, this._groupRepo, this.currentUser) : super(EventInitial());

  Future<void> loadUpcomingEvents() async {
    emit(EventInitial());
    try {
      _upcomingEvents = await _eventsRepo.getUpcomingEvents(currentUser);
      checkDateForEvents();
      emit(UpcomingEventLoaded(_upcomingEvents));
    } catch (_) {
      emit(EventError('Fehler beim Laden der Events'));
    }
  }

  Future<void> checkDateForEvents() async {
    for (var event in _upcomingEvents) {
      if (event.date.isBefore(DateTime.now())) {
      
        final updatedEvent = event.copyWith(isPast: true);
        await _eventsRepo.updateEvent(updatedEvent);
        createNextEvent(event);
      }
    } return;
  }

  Future<void> createNextEvent(GameNightEvent oldEvent) async {
    final group = await _groupRepo.getGroupById(oldEvent.groupId);
    final members = group.members;

    final currentIndex = members.indexWhere((u) => u.id == oldEvent.host.id);
    final nextIndex = (currentIndex + 1) % members.length;
    final nextHost = members[nextIndex];

    final newEvent = GameNightEvent(
      id: DateTime.now().millisecondsSinceEpoch, 
      name: oldEvent.name, 
      groupId: oldEvent.groupId, 
      host: nextHost, 
      date: oldEvent.date.add(Duration(days: oldEvent.recurrence)), 
      recurrence: oldEvent.recurrence, 
      isPast: false);

      await _eventsRepo.createEvent(newEvent);
      _upcomingEvents.removeWhere((e) => e.id == oldEvent.id);
      _upcomingEvents.add(newEvent);
  }

  bool hasEventForGroup(int groupId) {
    return _upcomingEvents.any((event) => event.groupId == groupId);
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