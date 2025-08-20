import './movie.dart';

class WatchListItem {
  String id;
  String firebaseUserId;
  int movieId;
  String type;
  DateTime? startDate;
  DateTime? endDate;
  Movie? movie;

  WatchListItem({
    required this.id,
    required this.firebaseUserId,
    required this.movieId,
    required this.type,
    this.startDate,
    this.endDate,
    this.movie
  });

  //factory constructor
  factory WatchListItem.fromJson(Map<String, dynamic> json) {
    return WatchListItem(
      id: json['id'] ?? '',
      firebaseUserId: json['firebase_user_id'] ?? '',
      movieId: json['movie_id'] ?? 0,
      type: json['type'] ?? '',
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      movie: json['movie'] != null ? Movie.fromJson(Map<String,dynamic>.from(json['movie'])) : null
    );
  }
}