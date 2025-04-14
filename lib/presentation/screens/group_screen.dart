import 'package:demo_game_night/presentation/widgets/group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';


class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final authState = context.read<AuthCubit>().state;
    if (authState is AuthSuccess) {
      context.read<GroupCubit>().loadGroups(authState.user.username);
    }
  }
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    
    if (authState is! AuthSuccess) {
      return const Scaffold(
        body: Center(child: Text('Du musst angemeldet sein')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Gruppen'),
      ),
      body: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, state) {
//Loading
          if (state is GroupLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
//Loaded
          else if (state is GroupLoaded) {
            final userGroups = state.groups;
            if (userGroups.isEmpty) {
              return const Center(child: Text('Du bist noch in keiner Gruppe'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: userGroups.length,
                    itemBuilder: (context, index) {
                      final group = userGroups[index];
                  
                      return GroupCard(group: group);
                    },              
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(onPressed: () {
                context.read<AuthCubit>().logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Ausloggen'),),
                  )
              ],
            );
          } else if (state is GroupError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Keine Daten verfügbar'));
        },
      ),
    );
  }
}
