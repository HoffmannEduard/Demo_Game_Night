import 'package:demo_game_night/data/mock_data.dart';
import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';

class FakeEventsRepo implements IEventsRepo {
  @override
  Future<void> createEvent(GameNightEvent newEvent) async {
    MockData.mockGameNightEvents.add(newEvent);
  }

  @override
  Future<List<GameNightEvent>> getPastEvents(User user) async {
    final userGroups = MockData.mockGroups
      .where((group) => group.members.any((member) => member.id == user.id))
      .map((group) => group.id)
      .toSet();

    return MockData.mockGameNightEvents
      .where((event) => event.isPast && userGroups.contains(event.groupId))
      .toList();
  }

  @override
  Future<List<GameNightEvent>> getUpcomingEvents(User user) async {
    final userGroups = MockData.mockGroups
      .where((group) => group.members.any((member) => member.id == user.id))
      .map((group) => group.id)
      .toSet();

    return MockData.mockGameNightEvents
      .where((event) => !event.isPast && userGroups.contains(event.groupId))
      .toList();
  }

  

}