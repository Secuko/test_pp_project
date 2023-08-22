import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_pp_project/models/models.dart';

class UserDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<User> loadValue() async {
    final login = (await sharedPreferences).getString('login') ?? '';
    final password = (await sharedPreferences).getString('password') ?? '';
    return User(login: login, password: password);
  }

  Future<void> saveValue(User user) async {
    (await sharedPreferences).setString('login', user.login);
    (await sharedPreferences).setString('password', user.password);
  }
}