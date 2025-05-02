import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_events_repo.dart';
import 'package:demo_game_night/presentation/widgets/upcoming_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatelessWidget {
  final User currentUser;
  const EventScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EventCubit(
        context.read<IEventsRepo>(), 
        currentUser)..loadUpcomingEvents(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bevorstehende Events'),
        ),
        body: UpcomingEventView(),
      ),
    );
  }
}