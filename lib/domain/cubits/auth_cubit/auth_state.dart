part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAwaitingAddress extends AuthState {
  final int id;
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  const AuthAwaitingAddress({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}


class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}


class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
