import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final IGroupRepo _groupRepo;
  final User currentUser;

  GroupCubit(this._groupRepo, this.currentUser) : super(GroupInitial());

  // Alle Gruppen abrufen
  Future<void> loadGroups() async {
  try {
    final userGroups = await _groupRepo.getGroups(currentUser);
    emit(GroupLoaded(userGroups));
  } catch (_) {
    emit(GroupError('Fehler beim Laden'));
  }
  }

  // Gruppen beim Ausloggen auf null setzen
  void reset() {
    emit(GroupInitial());
  }
}
