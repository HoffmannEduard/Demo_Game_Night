import 'package:demo_game_night/domain/entities/user.dart';

class Group {
  final String name;
  final List<User> members;

  Group({required this.name, required this.members});
}