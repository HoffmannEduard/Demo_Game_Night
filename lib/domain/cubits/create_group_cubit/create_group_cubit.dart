import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:demo_game_night/domain/i_repos/i_user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final IGroupRepo groupRepo;
  final IUserRepo userRepo;
  final User currentUser;

  CreateGroupCubit(this.groupRepo, this.userRepo, this.currentUser) : super(CreateGroupInitial());

  final List<User> _members = [];

  // Methode um den Gruppennamen zu aktualisieren
  void updateGroupName(String name) {
    emit(state.copyWith(groupName: name, errorMessage: null)); // UI Update
  }

  // Methode um ein Mitglied hinzuzufügen
  void tryAddMember(String username) async {
    if (username.isEmpty) {
      return;
    }

    // Prüfe ob der User existiert – hier solltest du die Logik anpassen, wie du den User holst
    final user = await userRepo.getUserByUsername(username);
    
    if (user != null) {
      _members.add(user);
      emit(state.copyWith(members: List.from(_members), errorMessage: null));
    } else {
      emit(state.copyWith(errorMessage: 'User existiert nicht'));
    }
  }

  // Methode um ein Mitglied zu entfernen
  void removeMember(User user) {
    _members.remove(user);
    emit(state.copyWith(members: List.from(_members)));
  }

  // Methode um die Gruppe zu erstellen 
  Future<void> createGroup() async {

    final membersWithCreator = List<User>.from(_members);
  if (!membersWithCreator.contains(currentUser)) {
    membersWithCreator.add(currentUser);
  }

  if (state.groupName.trim().isEmpty || state.members.isEmpty) {
    emit(state.copyWith(errorMessage: 'Bitte Gruppennamen und Mitglieder angeben'));
    return;
  }

  emit(state.copyWith(errorMessage: null)); // Fehler zurücksetzen

  final newGroup = Group(
    id: DateTime.now().millisecondsSinceEpoch,
    name: state.groupName,
    members: membersWithCreator,
  );

  await groupRepo.createGroup(newGroup);
  emit(state.copyWith(isSuccess: true));
}

}
