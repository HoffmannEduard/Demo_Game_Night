import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/entities/user_address.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';

class FakeUserRepo implements IUserRepo {
  // Fake User für Testzwecke, Methoden weiter unten
  final List<User> users = [
  User(
    username: "testuser1",      
    password: "password123",   
    firstName: "Max",          
    lastName: "Mustermann",    
    adress: UserAddress(
      plz: '97000',
      street: 'Musterstraße',
      number: '3',
      location: 'Musterstadt'        
    )
  ),
  User(
    username: "johndoe",      
    password: "johnpassword",   
    firstName: "John",          
    lastName: "Doe",    
    adress: UserAddress(
      plz: '97001',
      street: 'Hauptstraße',
      number: '10',
      location: 'Beispielstadt'        
    )
  ),
  User(
    username: "sarah_1985",      
    password: "sarahpass",   
    firstName: "Sarah",          
    lastName: "Müller",    
    adress: UserAddress(
      plz: '97002',
      street: 'Feldstraße',
      number: '25',
      location: 'Dorfstadt'        
    )
  ),
  User(
    username: "janedoe22",      
    password: "janepass",   
    firstName: "Jane",          
    lastName: "Doe",    
    adress: UserAddress(
      plz: '97003',
      street: 'Bahnhofstraße',
      number: '12',
      location: 'Kleinstadt'        
    )
  ),
  User(
    username: "hansw",      
    password: "hans1234",   
    firstName: "Hans",          
    lastName: "Wagner",    
    adress: UserAddress(
      plz: '97004',
      street: 'Kirchstraße',
      number: '4',
      location: 'Altstadt'        
    )
  )
];


  @override
  Future<void> addUser(User user) async {
    users.add(user);
  }

  @override
  Future<User?> getUser(String username, String password) async {
    try {
      return users.firstWhere(
        (u) => u.username == username && u.password == password
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> userExists(String username) async {
    return users.any((u) => u.username == username);
  }


}