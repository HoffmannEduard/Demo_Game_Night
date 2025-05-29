import 'package:demo_game_night/domain/cubits/message_cubit/message_cubit.dart';
import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMessageDialog extends StatelessWidget {
  final User currentUser;
  final GameNightEvent event;
  final TextEditingController _messageController = TextEditingController();

  EditMessageDialog({
    super.key,
    required this.currentUser,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.read<MessageCubit>().reset();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final cubit = context.read<MessageCubit>();
        return AlertDialog(
          title: Text('Nachricht an: ${event.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _messageController),
                if (state.errorMessage != null)
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(color: Colors.red),
                    ),
                  )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                cubit.reset();
              Navigator.of(context).pop(); 

              },
              child: const Text('Abbrechen'),
            ),
            IconButton(
              onPressed: () {
                cubit.updateMessage(_messageController.text.trim());
                cubit.sendMessage(event.id);
                
              },
              icon: Icon(Icons.send),
            ),
          ],
        );
      },
    );
  }
}
