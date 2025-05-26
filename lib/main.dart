import 'package:demo_game_night/data/repositories/supabase_events_repo.dart';
import 'package:demo_game_night/data/repositories/supabase_game_suggestion_repo.dart';
import 'package:demo_game_night/data/repositories/supabase_group_repo.dart';
import 'package:demo_game_night/data/repositories/supabase_rating_repo.dart';
import 'package:demo_game_night/data/repositories/supabase_user_repo.dart';
import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_suggestion_cubit/game_suggestion_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_vote/game_vote_cubit.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_game_suggestion_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_rating_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:demo_game_night/utilities/app_theme.dart';
import 'package:demo_game_night/utilities/auth_gate.dart';
// import 'package:demo_game_night/utilities/auth_persistence_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qeliofhvbnxwmzzkycms.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFlbGlvZmh2Ym54d216emt5Y21zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY5NzM2NjYsImV4cCI6MjA2MjU0OTY2Nn0.cLgGC8eBmr0zYIrxkbxpcXZjw_EYo-xL7oa549Fd3s4',
  );

  final IUserRepo userRepo = SupabaseUserRepo();
  final IGroupRepo groupRepo = SupabaseGroupRepo();
  final IEventsRepo eventsRepo = SupabaseEventsRepo();
  final IGameSuggestionRepo gameSuggestionRepo = SupabaseGameSuggestionRepo();
  final IRatingRepo ratingRepo = SupabaseRatingRepo();

  runApp(

    // Bietet die Repositories global an, Zugriff von jeder Seite möglich
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IUserRepo>.value(value: userRepo,),
        RepositoryProvider<IGroupRepo>.value(value: groupRepo,),
        RepositoryProvider<IEventsRepo>.value(value: eventsRepo,),
        RepositoryProvider<IGameSuggestionRepo>.value(value: gameSuggestionRepo,),
        RepositoryProvider<IRatingRepo>.value(value: ratingRepo),

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
          create: (context) => GameSuggestionCubit(context.read<IGameSuggestionRepo>()),
        ),
        BlocProvider(
          create: (context) => GameVoteCubit(context.read<IGameSuggestionRepo>()),
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
