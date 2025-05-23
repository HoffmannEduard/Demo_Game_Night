import 'package:demo_game_night/domain/entities/group.dart';
import 'package:demo_game_night/domain/entities/user.dart' as my_entities;
import 'package:demo_game_night/domain/i_repos/i_group_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseGroupRepo implements IGroupRepo {
  final supabase = Supabase.instance.client;

  @override
  Future<void> createGroup(Group newGroup) async {
    await supabase.from('groups').insert({
      'name': newGroup.name,
    });
  }

  @override
  Future<List<Group>> getGroups(my_entities.User user) async {
    final data = await supabase
        .from('groups')
        .select('id, name');

    return (data as List<dynamic>).map((g) => Group(
      id: g['id'],
      name: g['name'],
      members: [],
    )).toList();
  }

  @override
  Future<Group> getGroupById(int groupId) async {
    final res = await supabase
        .from('groups')
        .select('id, name')
        .eq('id', groupId)
        .maybeSingle();

    if (res == null) throw Exception('Group not found');

    return Group(
      id: res['id'],
      name: res['name'],
      members: [],
    );
  }
}