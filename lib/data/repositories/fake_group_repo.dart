import 'package:demo_game_night/data/repositories/fake_user_repo.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';

class FakeGroupRepo implements IGroupRepo {


  final List<Group> _groups = [
    Group(
      name: 'Fishermans Friends', 
      members: FakeUserRepo().users)
  ];

  @override
  Future<void> createGroup(String groupName, List<User> members) async {
    final newGroup = Group(name: groupName, members: members);
    _groups.add(newGroup);
  }

  @override
  Future<List<Group>> getGroups() async {
    return _groups;
  }
}