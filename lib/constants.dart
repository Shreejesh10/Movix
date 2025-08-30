import 'package:Movix/models/genre.dart';

const String API_URL =
    "https://movixbackend.onrender.com"; //IP Address of the running device (this laptop) for the emulators

const List<String> GENRES_NAME_ONLY = [
  'Action',
  'Adventure',
  'Animation',
  'Comedy',
  'Crime',
  'Documentary',
  'Drama',
  'Family',
  'Fantasy',
  'War',
  'History',
  'Horror',
  'Music',
  'Mystery',
  'Romance',
  'Science Fiction',
  'Thriller',
  'TV Movie',
  'Western',
];

final List<Genre> GENRES = [
  Genre(28, "Action"),
  Genre(12, "Adventure"),
  Genre(16, "Animation"),
  Genre(35, "Comedy"),
  Genre(80, "Crime"),
  Genre(99, "Documentary"),
  Genre(18, "Drama"),
  Genre(10751, "Family"),
  Genre(14, "Fantasy"),
  Genre(10752, "War"),
  Genre(36, "History"),
  Genre(27, "Horror"),
  Genre(10402, "Music"),
  Genre(9648, "Mystery"),
  Genre(10749, "Romance"),
  Genre(878, "Science Fiction"),
  Genre(53, "Thriller"),
  Genre(10770, "TV Movie"),
  Genre(37, "Western"),
];
