import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/cubits/create_group_cubit/create_group_cubit.dart';
import 'package:demo_game_night/domain/cubits/group_cubit/group_cubit.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:demo_game_night/presentation/screens/login_screen.dart';
import 'package:demo_game_night/presentation/widgets/create_group_dialog.dart';
import 'package:demo_game_night/presentation/widgets/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupScreen extends StatelessWidget {
  final User currentUser;
  const GroupScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gruppen'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              context.read<GroupCubit>().reset();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Willkommen, ${currentUser.firstName}',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text('Dein Username:'),
                Card(
                  color: Colors.amberAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      currentUser.username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Deine Gruppen:'),
                const Expanded(
                  child: GroupList(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: context.read<GroupCubit>()
                          ),
                        BlocProvider(
                          create: (_) => CreateGroupCubit(
                          context.read<IGroupRepo>(),
                          context.read<IUserRepo>(),
                          currentUser,
                      ),
                        )
                      ],
                      
                      child: CreateGroupDialog(),
                    );
                  },
                );
              },
              child: const Icon(Icons.group_add),
            ),
          ),
        ],
      ),
    );
  }
}
