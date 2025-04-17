import 'package:demo_game_night/data/mock_data.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';

class FakeUserRepo implements IUserRepo {



  @override
  Future<void> addUser(User user) async {
    MockData.mockUsers.add(user);
  }

  @override
  Future<User?> getUser(String username, String password) async {
    try {
      return MockData.mockUsers.firstWhere(
        (u) => u.username == username && u.password == password
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> userExists(String username) async {
    return MockData.mockUsers.any((u) => u.username == username);
  }

  @override
Future<User?> getUserByUsername(String username) async {
  try {
    return MockData.mockUsers.firstWhere((u) => u.username == username);
  } catch (_) {
    return null;
  }
}


}