import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:test_pp_project/models/models.dart';
import 'package:test_pp_project/api/translator.dart';

Future<List<Question>?> randomQuestionRequest() async {
  try {
    var url = Uri.https('jservice.io', '/api/random',{'count': '10'});
  var response = await http.get(url);
  //final response = await http.read(url);
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    if (response.statusCode == 200) {
      final questions = jsonResponse
          .map((dynamic e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
      print(questions);
      return await translate(questions);
    } else {
      return null;
    }
  } catch (e) {
    print('не удалось получить данные из сети');
    return null;
  }
      //return Question(value: 1, question: 'question', answer: 'answer', airDate: 'airDate', id: 1, created_at: 'created_at', game_id: 1, updated_at: 'updated_at', category_id: 1, category: Category(id: 1, title: 'title', created_at: 'created_at', updated_at: 'updated_at', clues_count: 1));
}
