import 'package:demo_game_night/domain/entities/user.dart';

abstract class IUserRepo {

  //Checkt ob ein User mit gleichen Username bereits existiert
  Future<bool> userExists(String username);

  Future<void> addUser(User user);
  
  Future<User?> getUser(String username, String password);
}