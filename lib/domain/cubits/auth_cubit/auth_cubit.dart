import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/entities/user_address.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
//import 'package:demo_game_night/utilities/auth_persistence_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IUserRepo _userRepo;
  //final AuthPersistenceService _authPersistenceService;
  
  // Hier wird der Peristence Service und das IRepository per DI injiziert
  AuthCubit(this._userRepo) : super(AuthInitial());

  // Persistence Service integrieren um zu checken, ob jemand angemeldet ist
  /*
  Future<void> checkIfUserIsLoggedIn() async {
    final credentials = await _authPersistenceService.getUser();
    if (credentials != null) {
      final user = await _userRepo.getUser(credentials['username']!, credentials['password']!);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthError('Login fehlgeschlagen'));
      }
    } else {
      emit(AuthInitial());
    }
  }
  */

// Erste Seite um Usernamen auf Einzigartigkeit zu prüfen, inkl. Angabe von Passwort, Vor- und Nachname
  Future<void> submitBasicInfo({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final exists = await _userRepo.userExists(username);

    if (exists) {
      emit(AuthError("Nutzername nicht verfügbar"));
    } else {
      // Zustand mit Nutzerdaten auf AuthAwaitingAdress setzen
      emit(AuthAwaitingAddress(
        id: DateTime.now().millisecondsSinceEpoch,
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName
      ));
    }
  }

// Adresse hinzufügen über UI
  Future<void> submitAdress(UserAddress address) async {
  final currentState = state as AuthAwaitingAddress;

  final newUser = User(
    id: DateTime.now().microsecondsSinceEpoch,
    username: currentState.username,
    password: currentState.password,
    firstName: currentState.firstName,
    lastName: currentState.lastName,
    adress: address
  );

  await _userRepo.addUser(newUser);
  emit(AuthSuccess(newUser));
}

// User existiert, login über Anmeldung
  Future<void> login(String username, String password) async {

    final user = await _userRepo.getUser(username, password);
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthError('Login fehlgeschlagen'));
    }
  }

// Logout-Funktion
  Future<void> logout() async {
    //await _authPersistenceService.clearUser();
    emit(AuthInitial()); // Benutzerstatus auf initialen Zustand setzen (Nicht angemeldet)
  }

}
