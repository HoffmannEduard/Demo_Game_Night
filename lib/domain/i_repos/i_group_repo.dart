import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';

abstract class IGroupRepo {
  
  Future<void> createGroup(Group newGroup);

  Future<List<Group>> getGroups(User user);
}