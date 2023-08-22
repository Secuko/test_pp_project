import 'package:test_pp_project/models/models.dart';

class Question {
  Question(
      {required this.value,
      required this.question,
      required this.answer,
      required this.airDate,
      required this.id,
      required this.created_at,
      required this.game_id,
      required this.updated_at,
      required this.category_id,
      required this.category});
  int value;
  String question;
  String answer;
  String airDate;
  int id;
  String created_at;
  String updated_at;
  int category_id;
  int game_id;
  Category category;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      //category: json['category'] as String,
      id: json['id'] as int,
      answer: json['answer'] as String,
      question: json['question'] as String,
      value: (json['value']  ?? 0) as int,
      airDate: json['airdate'] as String,
      created_at: json['created_at'] as String,
      updated_at: json['updated_at'] as String,
      category_id: json['category_id'] as int,
      game_id: json['game_id'] as int,
      //category: (json['category'] as dynamic).map((dynamic e) => Category.fromJson(e as Map<String, dynamic>)).toList(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
    );
  }
}


// class JsonCoder {
//   void encode() {}

//   void decode(String jsonString) {
//     try {
//       final json = jsonDecode(jsonString) as List<dynamic>;
//       final questions = json
//           .map((dynamic e) => Question.fromJson(e as Map<String, dynamic>))
//           .toList();
//       print(questions);
//     } catch (error) {
//       print(error);
//     }
//   }
// }
