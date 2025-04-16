import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupLoaded) {
          return ListView(
            children: state.groups.map((g) => ListTile(title: Text(g.name),)).toList(),
          );
        } else if (state is! GroupLoaded){
          return Center(child: Text('State ist $state'),);
        }
        return SizedBox();
      }
      );
  }
}