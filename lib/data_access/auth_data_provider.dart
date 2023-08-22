import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_pp_project/models/models.dart';

class AuthDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<AuthData> loadValue() async {
    final isAuthorized =
        (await sharedPreferences).getBool('isAuthorized') ?? false;
    return AuthData(error: '', isAuthorized: isAuthorized);
  }

  Future<void> saveValue(AuthData data) async {
    (await sharedPreferences).setBool('isAuthorized', data.isAuthorized);
  }
}