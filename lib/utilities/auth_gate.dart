import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/presentation/screens/login_screen.dart';
import 'package:demo_game_night/presentation/widgets/main_scaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;

    if (state is AuthSuccess) {
      return MainScaffold();
    } else {
      return LoginScreen();
    }
  }
}
