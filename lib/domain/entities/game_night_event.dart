import 'package:demo_game_night/domain/entities/user.dart';

class GameNightEvent {
  final int id;
  final User host;
  final String name;
  final DateTime date;
  
GameNightEvent({
 required this.id,
 required this.host,
 required this.name,
 required this.date
});
}