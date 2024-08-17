import 'package:alarm_front/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasource {
  static Future<void> saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_id', user.id.toString());
    await prefs.setString('user_name', user.displayName ?? '');
    await prefs.setString('user_email', user.email ?? '');
    await prefs.setString('user_photoUrl', user.photoUrl ?? '');
    await prefs.setString('user_loginType', user.loginType ?? '');
    await prefs.setString('user_uuid', user.uuid ?? '');
  }

  static Future<User?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');

    if (userId == null) return null;

    return User(
      id: int.tryParse(userId),
      displayName: prefs.getString('user_name'),
      email: prefs.getString('user_email'),
      loginType: prefs.getString('user_loginType'),
      photoUrl: prefs.getString('user_photoUrl'),
      uuid: prefs.getString('user_uuid'),
    );
  }

  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static const String _reservedRoomsKey = 'reserved_rooms';

  // 예약된 방 ID를 저장하는 메서드
  static Future<void> saveReservedRoom(int roomId) async {
    final prefs = await SharedPreferences.getInstance();
    final reservedRooms = prefs.getStringList(_reservedRoomsKey) ?? [];
    if (!reservedRooms.contains(roomId.toString())) {
      reservedRooms.add(roomId.toString());
      await prefs.setStringList(_reservedRoomsKey, reservedRooms);
    }
  }

  // 예약된 방 ID를 삭제하는 메서드
  static Future<void> removeReservedRoom(int roomId) async {
    final prefs = await SharedPreferences.getInstance();
    final reservedRooms = prefs.getStringList(_reservedRoomsKey) ?? [];
    reservedRooms.remove(roomId.toString());
    await prefs.setStringList(_reservedRoomsKey, reservedRooms);
  }

  // 예약된 방 목록을 불러오는 메서드
  static Future<List<int>> getReservedRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final reservedRooms = prefs.getStringList(_reservedRoomsKey) ?? [];
    return reservedRooms.map((roomId) => int.parse(roomId)).toList();
  }
}
