import 'package:demo_game_night/domain/entities/user_address.dart';

class User {
  int id;
  String username;
  String password;
  String firstName;
  String lastName;
  UserAddress address;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.address
  });

}