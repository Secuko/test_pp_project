import 'package:test_pp_project/models/models.dart';
import 'package:translator/translator.dart';

Future<List<Question>> translate(List<Question> questions) async {
  final translator = GoogleTranslator();
  for (var i = 0; i < questions.length; i++) {
    late String answer;
    late String question;
    try {
      answer =
          (await translator.translate(questions[i].answer, from: 'en', to: 'ru')).toString();
      question = (await translator.translate(questions[i].question,
          from: 'en', to: 'ru')).toString();
    } catch (e) {
      answer = 'We cant translate this answer';
      question = 'We cant translate this question';
    }
    questions[i].question = question;
    questions[i].answer = answer;
  }
  return questions;
}
