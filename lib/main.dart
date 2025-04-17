import 'package:demo_game_night/data/repositories/fake_group_repo.dart';
import 'package:demo_game_night/data/repositories/fake_user_repo.dart';
import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/create_group_cubit/create_group_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:demo_game_night/utilities/app_theme.dart';
import 'package:demo_game_night/utilities/auth_gate.dart';
// import 'package:demo_game_night/utilities/auth_persistence_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final IUserRepo userRepo = FakeUserRepo();
  final IGroupRepo groupRepo = FakeGroupRepo();

  MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(userRepo)),
        BlocProvider(create: (context) {
          final authCubit = context.read<AuthCubit>();
          return GroupCubit(groupRepo, authCubit);
        }),
        BlocProvider(create: (context) => CreateGroupCubit(groupRepo, userRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Game Night App',
        theme: AppTheme.boardGameTheme,
        home: AuthGate(),
      ),
    );
  }
}
