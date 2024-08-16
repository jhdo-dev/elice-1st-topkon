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
}
