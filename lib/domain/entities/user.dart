import 'package:demo_game_night/domain/entities/user_address.dart';

class User {
  String username;
  String password;
  String firstName;
  String lastName;
  UserAddress adress;

  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.adress
  });

}