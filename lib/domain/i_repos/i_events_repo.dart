import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart';

abstract class IEventsRepo {

Future<void> createEvent(GameNightEvent newEvent);

Future<List<GameNightEvent>> getUpcomingEvents(User user);

Future<List<GameNightEvent>> getPastEvents(User user);

Future<void> updateEvent(GameNightEvent updatedEvent);

}