import 'package:demo_game_night/domain/entities/user.dart';

class GameNightEvent {
  final int id;
  final int groupId;
  final User host;
  final DateTime date;
  final int recurrence;
  final bool isPast;

  
GameNightEvent({
 required this.id,
 required this.groupId,
 required this.host,
 required this.date,
 required this.recurrence,
 required this.isPast,
});
}