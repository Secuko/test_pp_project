import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pp_project/utils/utils.dart';
import 'package:test_pp_project/bloc/blocs.dart';
import 'package:test_pp_project/models/models.dart';

class StartGameScreen extends StatelessWidget {
  const StartGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return Scaffold(
      //appBar: const CustomAppBar( color: AppColors.neutralBlue),
      body: Container(
        alignment: Alignment.center,
        color: AppColors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            StreamBuilder(
              initialData: bloc.state,
              stream: bloc.stream,
              builder: (context, snapshot) {
                final gameIsStart = snapshot.requireData.session.gameIsStart;
                final gameIsEnd = snapshot.requireData.session.gameIsEnd;
                if (gameIsStart == false && gameIsEnd == false) {
                  return const StartGameButton();
                } else {
                  return const GameField();
                }
              },
            ),
            StreamBuilder(
              initialData: bloc.state,
              stream: bloc.stream,
              builder: (context, snapshot) {
                final gameIsStart = snapshot.requireData.session.gameIsStart;
                final gameIsEnd = snapshot.requireData.session.gameIsEnd;
                if (gameIsStart == true && gameIsEnd == true) {
                  return const WinnerTable();
                } else {
                  return const SizedBox.square();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StartGameButton extends StatelessWidget {
  const StartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return GestureDetector(
      onTap: () => bloc.startGame(),
      child: SizedBox(
        height: 80,
        width: 160,
        child: Container(
          alignment: Alignment.center,
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            border: Border.all(width: 1, color: AppColors.black),
            color: AppColors.neutralBlue,
          ),
          child: const Text('Start'),
        ),
      ),
    );
  }
}

class GameField extends StatelessWidget {
  const GameField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return SizedBox(
      height: 500,
      child: Container(
        decoration:  const BoxDecoration(
          color: AppColors.white1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          //top: 50,
        ),
        child: Column(
          children: [
            const ScoreField(),
            SizedBox(
              height: 5,
              child: Container(
                color: AppColors.neutralBlue,
              ),
            ),
            const QuestionField(),
            StreamBuilder(
                initialData: bloc.state,
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final showAnswer = snapshot.requireData.session.showAnswer;
                  if (showAnswer) {
                    return const AnswerField();
                  } else {
                    return const SizedBox(
                      height: 40,
                    );
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const ManageField(),
          ],
        ),
      ),
    );
  }
}

class ScoreField extends StatelessWidget {
  const ScoreField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: 400,
        child: Column(
          children: [
            Row(
              children: [
                const PlayerName(
                  index: 1,
                ),
                Expanded(
                  child: Container(),
                ),
                const PlayerName(
                  index: 2,
                ),
              ],
            ),
            Row(
              children: [
                const PlayerScore(
                  index: 1,
                ),
                Expanded(
                  child: Container(),
                ),
                const PlayerScore(
                  index: 2,
                ),
              ],
            ),
          ],
        ));
  }
}

class QuestionField extends StatelessWidget {
  const QuestionField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return SizedBox(
      width: 400,
      height: 295,
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: StreamBuilder(
            initialData: bloc.state,
            stream: bloc.stream,
            builder: (context, snapshot) {
              final questions = snapshot.requireData.session.questions;
              final round = snapshot.requireData.session.round;
              if (questions.isNotEmpty) {
                return Text(questions[round].question);
              } else {
                return const Text('question is empty');
              }
            },
          ),
          //   const Text(
          //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas posuere felis in rutrum sodales. Fusce lacinia scelerisque tortor, eget congue elit imperdiet ac. Donec sit amet purus velit. Ut facilisis molestie elit at tincidunt. Maecenas pharetra mauris eget molestie egestas. Nullam condimentum aliquet dolor, et varius mauris rutrum ac. Nam et urna libero. Aenean aliquet lorem libero, eget egestas enim tristique sit amet. Proin et libero ipsum.'),
          // )),
        ),
      ),
    );
  }
}

class AnswerField extends StatelessWidget {
  const AnswerField({super.key});

  //final bool state = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return SizedBox(
      height: 40,
      child: Center(
        child: StreamBuilder(
            initialData: bloc.state,
            stream: bloc.stream,
            builder: (context, snapshot) {
              final questions = snapshot.requireData.session.questions;
              final round = snapshot.requireData.session.round;
              if (questions.isNotEmpty) {
                return Text(questions[round].answer);
              } else {
                return const Text('answer is empty');
              }
            }),
      ),
    );
  }
}

class ManageField extends StatelessWidget {
  const ManageField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IncreaseScoreButton(
            index: 1,
          ),
          Expanded(
              child: StreamBuilder(
                  initialData: bloc.state,
                  stream: bloc.stream,
                  builder: (context, snaphot) {
                    final showAnswer = snaphot.requireData.session.showAnswer;
                    if (showAnswer) {
                      return const NextQuestionButton();
                    } else {
                      return const AnswerButton();
                    }
                  })),
          const IncreaseScoreButton(
            index: 2,
          ),
        ],
      ),
    );
  }
}

class PlayerName extends StatelessWidget {
  const PlayerName({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      margin: (index == 1)
          ? const EdgeInsets.only(left: 20)
          : const EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      child: (index == 1) ? const Text('Player 1') : const Text('Player 2'),
    );
  }
}

class PlayerScore extends StatelessWidget {
  const PlayerScore({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return Container(
      height: 40,
      width: 80,
      margin: (index == 1)
          ? const EdgeInsets.only(left: 20)
          : const EdgeInsets.only(right: 20),
      alignment: Alignment.center,
      child: StreamBuilder<SessionState>(
          initialData: bloc.state,
          stream: bloc.stream,
          builder: (context, snapshot) {
            final int score;
            if (index == 1) {
              score = snapshot.requireData.session.firstPlayerScore;
            } else {
              score = snapshot.requireData.session.secondPlayerScore;
            }
            return Text('$score');
          }),
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return GestureDetector(
      onTap: () => bloc.showAnswer(),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: const Text(
          '?',
          style: TextStyle(
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}

class IncreaseScoreButton extends StatelessWidget {
  const IncreaseScoreButton({super.key, required this.index});
  final int index;
  

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return StreamBuilder(
      initialData: bloc.state,
      stream: bloc.stream,
      builder: (context, snapshot) {
        final showAnswer = snapshot.requireData.session.showAnswer;
        final scoreHasChange;
        if(index==1){
          scoreHasChange = snapshot.requireData.session.firstPlayerScoreHasChange;
        } else {
          scoreHasChange = snapshot.requireData.session.secondPlayerScoreHasChange;
        }
        bool isActive = false;
        if(showAnswer==true && scoreHasChange==false){
          isActive = true;
        } 
        //return bloc.increasePlayerScore(100, index);
        return GestureDetector(
          onTap: (isActive) ? () => bloc.increasePlayerScore(100, index) : null,
          child: SizedBox(
            height: 60,
            width: 120,
            child: Container(
              decoration: BoxDecoration(
                  color: (isActive) ? AppColors.greenLight : AppColors.whiteGrey,
                  borderRadius: (index == 1)
                      ? const BorderRadius.only(bottomLeft: Radius.circular(10))
                      : const BorderRadius.only(
                          bottomRight: Radius.circular(10))),
              alignment: Alignment.center,
              child: const Icon(
                Icons.add,
                size: 35,
              ),
            ),
          ),
        );
      },
    );
  }
}

class NextQuestionButton extends StatelessWidget {
  const NextQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return GestureDetector(
      onTap: () => bloc.getNextQuestion(),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: const Icon(
          Icons.skip_next,
          size: 35,
        ),
      ),
    );
  }
}

class WinnerTable extends StatelessWidget {
  const WinnerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SessionCubit>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.whiteWithOpacity,
      child: UnconstrainedBox(
        child: SizedBox(
          width: 200,
          height: 100,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: AppColors.whiteLight,
              border: Border.all(color: AppColors.black, width: 1),
            ),
            child: Column(
              children: [
                StreamBuilder(
                  initialData: bloc.state,
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    final firstPlayerScore =
                        snapshot.requireData.session.firstPlayerScore;
                    final secondPlayerScore =
                        snapshot.requireData.session.secondPlayerScore;
                    if (firstPlayerScore > secondPlayerScore) {
                      return const Text('Player 1 win');
                    } else if (firstPlayerScore < secondPlayerScore) {
                      return const Text('Player 2 win');
                    } else {
                      return const Text('Friendship win!');
                    }
                  },
                ),
                GestureDetector(
                  onTap: () => bloc.restartGame(),
                  child: const SizedBox.square(
                    dimension: 50,
                    child: Icon(
                      Icons.restart_alt,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}