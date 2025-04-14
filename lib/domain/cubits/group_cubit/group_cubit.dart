
import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final IGroupRepo _groupRepo;

  GroupCubit(this._groupRepo) : super(GroupInitial());

  Future<void> createGroup(String groupName, List<User> users) async {
    emit(GroupLoading());
    try {
      await _groupRepo.createGroup(groupName, users);
      final groups = await _groupRepo.getGroups();
      emit(GroupLoaded(groups)); // Gruppen erfolgreich geladen
    } catch (e) {
      emit(GroupError('Fehler beim Erstellen der Gruppe'));
    }
  }

  // Alle Gruppen abrufen
  Future<void> loadGroups(String currentUsername) async {
  emit(GroupLoading());

  try {
    final allGroups = await _groupRepo.getGroups(); // oder was dein FakeRepo anbietet
    final userGroups = allGroups.where(
      (group) => group.members.any((member) => member.username == currentUsername),
    ).toList();

    emit(GroupLoaded(userGroups));
  } catch (e) {
    emit(GroupError("Fehler beim Laden der Gruppen"));
  }
}
}
