import 'package:demo_game_night/data/mock_data.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';

class FakeGroupRepo implements IGroupRepo {

  @override
  Future<void> createGroup(String groupName, List<User> members) async {
    final newGroup = Group(id: DateTime.now().millisecondsSinceEpoch, name: groupName, members: members);
    MockData.mockGroups.add(newGroup);
  }

  @override
  Future<List<Group>> getGroups() async {
    return MockData.mockGroups;
  }
}