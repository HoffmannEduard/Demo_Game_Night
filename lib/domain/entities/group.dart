import 'package:demo_game_night/domain/entities/user.dart';

class Group {
  final int id;
  final String name;
  final List<User> members;
  final List<int>? eventIds;

  Group({
    required this.id,
    required this.name, 
    required this.members,
    this.eventIds
    });
    
}