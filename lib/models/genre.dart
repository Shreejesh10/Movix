class Genre {
  int id;
  String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      json['id'] as int,
      json['name'] as String,
    );
  }
}