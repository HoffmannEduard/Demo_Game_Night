part of 'create_group_cubit.dart';

class CreateGroupState extends Equatable {
  final String groupName;
  final List<User> members;
  final String? errorMessage;
  final bool isSuccess;

  const CreateGroupState({
    this.groupName = '',
    this.members = const [],
    this.errorMessage,
    this.isSuccess = false,
  });

  // Kopiermethode für einfaches Update des States
  CreateGroupState copyWith({
    String? groupName,
    List<User>? members,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return CreateGroupState(
      groupName: groupName ?? this.groupName,
      members: members ?? this.members,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [groupName, members, errorMessage, isSuccess];
}

class CreateGroupInitial extends CreateGroupState {}
