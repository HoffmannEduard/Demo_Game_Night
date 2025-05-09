import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthCubit>().logout();
        context.read<GroupCubit>().reset();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      icon: const Icon(Icons.logout),
    );
  }
}