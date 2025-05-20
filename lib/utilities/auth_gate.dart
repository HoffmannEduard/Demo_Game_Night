import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_suggestion_cubit/game_suggestion_cubit.dart';
import 'package:demo_game_night/domain/cubits/game_vote/game_vote_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/presentation/screens/login_screen.dart';
import 'package:demo_game_night/presentation/widgets/main_scaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AuthCubit>().state;

    if (state is AuthSuccess) {
      final user = state.user;
//Bei erfolgreichen Login werden dem angemeldeten User Gruppen und Events zugänglich gemacht
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => GroupCubit(
              ctx.read<IGroupRepo>(),
              user,
            ),
          ),
          BlocProvider(
            create: (ctx) => EventCubit(
              ctx.read<IEventsRepo>(),
              ctx.read<IGroupRepo>(),
              user,
            ),
          ),
          BlocProvider(
            create: (context) => GameSuggestionCubit(),
          ),
          BlocProvider(
            create: (context) => GameVoteCubit(),
          ),
          // Add other BlocProviders here if needed
        ],
//MainScaffold bietet die NavigationBar (Navigation über Icons am unteren Bildschirmrand) an
        child: MainScaffold(currentUser: user),
      );
    } else {
      return LoginScreen();
    }
  }
}