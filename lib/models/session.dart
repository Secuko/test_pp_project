import 'package:test_pp_project/models/models.dart';

class Session {
  List<Question> questions;
  int firstPlayerScore;
  int secondPlayerScore;
  bool gameIsStart;
  bool gameIsEnd;
  int currentPlayer;
  bool showAnswer;
  int round;
  bool firstPlayerScoreHasChange;
  bool secondPlayerScoreHasChange;

  Session(
      {
      required this.firstPlayerScore,
      required this.secondPlayerScore,
      required this.firstPlayerScoreHasChange,
      required this.secondPlayerScoreHasChange,
      required this.gameIsStart,
      required this.currentPlayer,
      required this.questions,
      required this.showAnswer,
      required this.round,
      required this.gameIsEnd});

  Session.empty({
    this.currentPlayer = 1,
    this.secondPlayerScoreHasChange = false,
    this.round = 0,
    this.gameIsEnd = false,
    this.showAnswer = false,
    this.questions = const [],
    this.firstPlayerScore = 0,
    this.secondPlayerScore = 0,
    this.gameIsStart = false,
    this.firstPlayerScoreHasChange = false
  });


  Session copyWith({
    List<Question>? questions,
    DateTime? gameStartTime,
    int? firstPlayerScore,
    int? secondPlayerScore,
    bool? gameIsStart,
    bool? gameIsEnd,
    int? currentPlayer,
    bool? showAnswer,
    int? round,
    bool? firstPlayerScoreHasChange,
    bool? secondPlayerScoreHasChange,
  }) {
    return Session(
      questions: questions ?? this.questions,
      firstPlayerScore: firstPlayerScore ?? this.firstPlayerScore,
      secondPlayerScore: secondPlayerScore ?? this.secondPlayerScore,
      gameIsStart: gameIsStart ?? this.gameIsStart,
      gameIsEnd: gameIsEnd ?? this.gameIsEnd,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      showAnswer: showAnswer ?? this.showAnswer,
      round: round ?? this.round,
      firstPlayerScoreHasChange:
          firstPlayerScoreHasChange ?? this.firstPlayerScoreHasChange,
      secondPlayerScoreHasChange:
          secondPlayerScoreHasChange ?? this.secondPlayerScoreHasChange,
    );
  }
}
