class Category {
  Category(
      {required this.id,
      required this.title,
      required this.created_at,
      required this.updated_at,
      required this.clues_count});
  int id;
  String title;
  String created_at;
  String updated_at;
  int clues_count;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        title: json['title'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        clues_count: json['clues_count']);
  }
}