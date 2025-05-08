import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/entities/user_address.dart';

class MockData {
// Fake User List
static final mockUsers = [
  User(
    id: 1,
    username: "testuser",      
    password: "password",   
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
    id: 2,
    username: "johndoe",      
    password: "password",   
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
    id: 3,
    username: "sarah",      
    password: "password",   
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
    id: 4,
    username: "janedoe",      
    password: "password",   
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
    id: 5,
    username: "hansw",      
    password: "password",   
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

// Fake Group List
static var mockGroups = [
  Group(
    id: 10,
    name: 'Fishermans Friends', 
    members: [mockUsers[0],
      mockUsers[1],
      mockUsers[2],
      mockUsers[3]
]),
  Group(
    id: 11,
    name: 'Game Wikings',
    members: [mockUsers[0],
    mockUsers[2]] 
    ),
];

// Fake Game Night Events List
static final mockGameNightEvents = [
  GameNightEvent(
    id: 20,
    name: 'Fishermans Friends',
    groupId: 10,
    host: mockGroups[0].members[0],
    date: DateTime(2025, 5, 1, 18, 00),
    recurrence: 14,
    isPast: true
  ),
  GameNightEvent(
    id: 21, 
    name: 'Game Vikings',
    groupId: 11, 
    host: mockGroups[1].members[0], 
    date: DateTime(2025, 5, 10, 20, 00), 
    recurrence: 14, 
    isPast: false)
];
}