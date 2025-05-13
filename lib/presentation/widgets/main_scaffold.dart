import 'package:demo_game_night/domain/cubits/event_cubit/event_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/presentation/screens/event_screen.dart';
import 'package:demo_game_night/presentation/screens/group_screen.dart';
import 'package:demo_game_night/presentation/screens/news_screen.dart';
import 'package:demo_game_night/presentation/screens/past_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScaffold extends StatefulWidget {
  final User currentUser; 
  const MainScaffold({super.key, required this.currentUser});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 1;
  late final List<Widget> _screens;

@override
void initState() {
  super.initState();
  _screens = [
    GroupScreen(currentUser: widget.currentUser),
    EventScreen(currentUser: widget.currentUser),
    PastEventsScreen(currentUser: widget.currentUser),
    NewsScreen(currentUser: widget.currentUser),
  ];

  _loadDataForTab(_selectedIndex);
}

//Beim klicken auf das Icon in der NavigationBar werden die Daten neu geladen
void _loadDataForTab(int index) async {
    switch (index) {
      case 0:
        await context.read<GroupCubit>().loadGroups();
        break;
      case 1:
        await context.read<EventCubit>().loadUpcomingEvents();
        break;
      case 2:
        await context.read<EventCubit>().loadPastEvents();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
           _loadDataForTab(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.group), label: 'Gruppen'),
          NavigationDestination(icon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Rating'),
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'News'),
        ],
      ),
      );
  }
}
