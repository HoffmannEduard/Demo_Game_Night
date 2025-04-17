
import 'package:demo_game_night/domain/cubits/auth_cubit/auth_cubit.dart';
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final IGroupRepo _groupRepo;
  final AuthCubit authCubit;

  GroupCubit(this._groupRepo, this.authCubit) : super(GroupInitial());

  
  // Alle Gruppen abrufen
  Future<void> loadGroups() async {
    emit(GroupInitial()); // Neuer, leerer Ladezustand
  try {
    final allGroups = await _groupRepo.getGroups();
    final authState = authCubit.state;
      if(authState is AuthSuccess) {
        final userId = authState.user.id;
        final filtered = allGroups.where((g) => g.members.any((m) => m.id == userId)).toList();
            
        emit(GroupLoaded(filtered));
      } else {
        emit(GroupError('If Block in loadGroups nicht ausgeführt'));
      }
  } catch (_) {
    emit(GroupError('Fehler beim Laden'));
  }
}



// Gruppen beim ausloggen auf null setzen
   void reset() {
    emit(GroupInitial());
  }
}
