import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/create_group_cubit/create_group_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:demo_game_night/presentation/screens/login_screen.dart';
import 'package:demo_game_night/presentation/widgets/create_group_dialog.dart';
import 'package:demo_game_night/presentation/widgets/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gruppen'),
        actions: [
          if (authState is AuthSuccess)
            IconButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
                context.read<GroupCubit>().reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              }, 
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          if (authState is AuthInitial) ...[
            Text('Nicht eingeloggt')
          ] 
          
          else if (authState is AuthSuccess) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Willkommen, ${authState.user.firstName}',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('Dein Nutzername:'),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        authState.user.username,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500
                        ),
                        ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text('Deine Gruppen:'),
                  Expanded(
                    child: GroupList()
                  )
                ],
              )
              ),
              FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return BlocProvider(
                        create: (_) => CreateGroupCubit(
                          context.read<IGroupRepo>(), 
                          context.read<IUserRepo>(),
                          authState.user),
                        child: CreateGroupDialog(),
                        );
                    } 
                  );
                },
                child: Icon(Icons.group_add),
              ),

          ]
        ],       
      ),
      
    );
  }
}