part of 'group_cubit.dart';

sealed class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

final class GroupInitial extends GroupState {}

final class GroupLoaded extends GroupState {
  final List<Group> groups;
  const GroupLoaded(this.groups);

}

class GroupError extends GroupState {
  final String message;
  const GroupError(this.message);
}