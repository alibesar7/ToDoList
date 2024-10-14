class Movie {
  int? id;
  String title;
  String date;

  Movie({this.id, required this.title, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      date: map['date'],
    );
  }
}