import 'package:demo_game_night/data/repositories/fake_group_repo.dart';
import 'package:demo_game_night/data/repositories/fake_user_repo.dart';
import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:demo_game_night/presentation/screens/group_screen.dart';
import 'package:demo_game_night/presentation/screens/login_screen.dart';
import 'package:demo_game_night/utilities/app_theme.dart';
// import 'package:demo_game_night/utilities/auth_persistence_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        BlocProvider(create: (context) => GroupCubit(groupRepo)), 
      ],
      child: MaterialApp(
        title: 'Game Night App',
        theme: AppTheme.lightTheme,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/group': (context) => GroupScreen()
        },
      ),
    );
  }
}
