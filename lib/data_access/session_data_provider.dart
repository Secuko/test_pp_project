import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_pp_project/models/models.dart';

class SessionDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();
  Future<Session> loadValue() async {
    final gameIsStart =
        (await sharedPreferences).getBool('gameIsStart') ?? false;
    final gameIsEnd = (await sharedPreferences).getBool('gameIsEnd') ?? false;
    if (gameIsStart == false) {
      return Session(
          firstPlayerScoreHasChange: false,
          secondPlayerScoreHasChange: false,
          round: 0,
          gameIsEnd: false,
          showAnswer: false,
          questions: [],
          firstPlayerScore: 0,
          secondPlayerScore: 0,
          gameIsStart: false,
          currentPlayer: 1);
    } else {
      final firstPlayerScore =
          (await sharedPreferences).getInt('firstPlayerScore') ?? 0;
      final secondPlayerScore =
          (await sharedPreferences).getInt('secondPlayerScore') ?? 0;
      final currentPlayer =
          (await sharedPreferences).getInt('currentPlayer') ?? 1;
      final round = (await sharedPreferences).getInt('round') ?? 1;
      return Session(
          firstPlayerScoreHasChange: false,
          secondPlayerScoreHasChange: false,
          gameIsEnd: gameIsEnd,
          round: round,
          showAnswer: false,
          questions: [],
          // DateTime.parse(gameStartTime.split('.').reversed.join()),
          firstPlayerScore: firstPlayerScore,
          secondPlayerScore: secondPlayerScore,
          gameIsStart: true,
          currentPlayer: currentPlayer);
    }
  }

  Future<void> saveValue(Session session) async {
    (await sharedPreferences).setBool('gameIsStart', session.gameIsStart);
    (await sharedPreferences).setBool('gameIsEnd', session.gameIsEnd);
    (await sharedPreferences)
        .setInt('firstPlayerScore', session.firstPlayerScore);
    (await sharedPreferences)
        .setInt('secondPlayerScore', session.secondPlayerScore);
    (await sharedPreferences).setInt('currentPlayer', session.currentPlayer);
    (await sharedPreferences).setInt('round', session.round);
  }
}
