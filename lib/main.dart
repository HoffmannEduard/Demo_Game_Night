import 'package:demo_game_night/data/repositories/fake_events_repo.dart';
import 'package:demo_game_night/data/repositories/fake_group_repo.dart';
import 'package:demo_game_night/data/repositories/fake_user_repo.dart';
import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_suggestion_cubit/game_suggestion_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_vote/game_vote_cubit.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:demo_game_night/utilities/app_theme.dart';
import 'package:demo_game_night/utilities/auth_gate.dart';
// import 'package:demo_game_night/utilities/auth_persistence_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  final IUserRepo userRepo = FakeUserRepo();
  final IGroupRepo groupRepo = FakeGroupRepo();
  final IEventsRepo eventsRepo = FakeEventsRepo();

  runApp(

    // Bietet die Repositories global an, Zugriff von jeder Seite möglich
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IUserRepo>.value(value: userRepo,),
        RepositoryProvider<IGroupRepo>.value(value: groupRepo,),
        RepositoryProvider<IEventsRepo>.value(value: eventsRepo,),

      ], 
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
  //AuthCubit wird global benötigt um den angemeldeten User zu identifizieren

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(context.read<IUserRepo>()),
        ),
        BlocProvider(
          create: (context) => GameSuggestionCubit(),
        ),
        BlocProvider(
          create: (context) => GameVoteCubit(),
        ),
        // Add other BlocProviders here if needed
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
