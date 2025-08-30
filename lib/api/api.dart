import 'package:Movix/constants.dart';
import 'package:Movix/models/userStatistics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:Movix/models/allModels.dart';
import 'package:Movix/features/services/cache_service.dart';

Future<Map<String, String>> getHeaders() async {
  //Used to get headers from the firebase
  // Get Firebase ID Token
  final user = FirebaseAuth.instance.currentUser;
  final idToken = await user?.getIdToken();

  if (idToken == null) {
    throw Exception("Failed to get Firebase ID token");
  }

  return {
    "Content-Type": "application/json",
    "Authorization": "Bearer $idToken", // ✅ send token here
  };
}

String? getUserId() {
  // Get Firebase userID
  final user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid;
  return uid;
}

Future<void> addUserData(
  String uid,
  String userName,
  String email,
  String signUpMethod,
) async {
  try {
    final url = Uri.parse('$API_URL/user/add_user_data');

    final body = jsonEncode({
      "firebase_user_id": uid,
      "user_name": userName,
      "email": email,
      "sign_up_method": signUpMethod,
    });

    final headers = await getHeaders();

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log("✅ User data sent successfully: ${response.body}");
    } else {
      log(
        "❌ Failed to send user data: ${response.statusCode} ${response.body}",
      );
    }
  } catch (e) {
    log("Error sending user data: $e");
  }
}

Future<List<Genre>> getCurrentUserPreferences() async {
  try {
    final firebaseUid = getUserId();
    if (firebaseUid == null) {
      log("Error: Failed to get userID");
      return [];
    }

    final url = Uri.parse("$API_URL/user/get_user_preferences/$firebaseUid");
    final headers = await getHeaders();
    final response = await http.get(url, headers: headers);
    final data = jsonDecode(response.body);

    // map the preferences JSON into Genre objects
    final List<dynamic> prefsJson = data['preferences'];
    final preferences = prefsJson.map((json) => Genre.fromJson(json)).toList();

    return preferences;
  } catch (e) {
    log("Error while getting current preferences: $e");
    return [];
  }
}

Future<String> updateUserPreferences(List<Genre> genres) async {
  try {
    final url = Uri.parse("$API_URL/user/update_user_preferences");
    final genresJson = genres
        .map((g) => {"genre_id": g.id, "genre_name": g.name})
        .toList();

    final uid = getUserId();

    if (uid == null) {
      return "Error: Failed to get userID";
    }

    final body = jsonEncode({
      "firebase_user_id": uid,
      "preferences": genresJson,
    });

    final headers = await getHeaders();

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log("✅ Updated user preference successfully: ${response.body}");
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      log(
        "❌ Failed to send user data: ${response.statusCode} ${response.body}",
      );
      final data = jsonDecode(response.body);
      return "Error: An error occurred while updating preferences.";
    }
  } catch (e) {
    log("Error while updating preferences: $e");
    return "Error: An error occurred while updating preferences.";
  }
}

Future<List<Movie>> getRecommendedMovies() async {
  try {
    final firebaseUid = getUserId();
    if (firebaseUid == null) {
      log("Error: Failed to get userID");
      return [];
    }

    final url = Uri.parse("$API_URL/movies/get_recommendation/$firebaseUid");
    final headers = await getHeaders();

    log("Making recommended movie request to $url");
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> moviesJson = data['data'];
      print(moviesJson[0]['production_companies']);
      final movies = moviesJson.map((json) => Movie.fromJson(json)).toList();

      // cache
      await CacheService.setValue("recommendedMovies", moviesJson);

      return movies;
    } else {
      log("Error fetching recommendations: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    log("Error while fetching recommendations: $e");
    return [];
  }
}

Future<List<Movie>> getPopularMovies() async {
  try {
    final url = Uri.parse("$API_URL/movies/get_popular_titles");
    final headers = await getHeaders();

    log("Making popular movie request to $url");
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> moviesJson = data['data'];
      final movies = moviesJson.map((json) => Movie.fromJson(json)).toList();

      // cache
      await CacheService.setValue("popularMovies", moviesJson);

      return movies;
    } else {
      log("Error fetching popular movies: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    log("Error while fetching popular movies: $e");
    return [];
  }
}

Future<List<WatchListItem>> getWatchList() async{
  try {
    final firebaseUid = getUserId();
    if (firebaseUid == null) {
      log("Error: Failed to get userID");
      return [];
    }

    final url = Uri.parse("$API_URL/user/get_watchlist/$firebaseUid");
    final headers = await getHeaders();

    log("Making watchlist request to $url");
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> watchListJson = data['data'];
      final watchList = watchListJson.map((json) => WatchListItem.fromJson(json)).toList();

      return watchList;
    } else {
      log("Error fetching watchList: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    log("Error while fetching watchlist: $e");
    return [];
  }
}

Future<String> addMovieToWatchList(
    int movieId,
    String type,
    DateTime? startDate,
    DateTime? endDate,
) async{
  try {
    final url = Uri.parse("$API_URL/user/add_movie_to_list");
    final headers = await getHeaders();

    final firebaseUid = getUserId();
    if (firebaseUid == null) {
      log("Error: Failed to get userID");
      throw "Failed to get userID";
    }

    final body = jsonEncode({
      'firebase_user_id': firebaseUid,
      'movie_id': movieId,
      'status': type.toLowerCase() == "currently watching" ? "Watching" : type.toLowerCase() == "plan to watch" ? "Plan To Watch" : "Completed",
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String()
    });

    log("Making add movie request to $url");
    final response = await http.post(url, headers: headers, body:body);

    if (response.statusCode == 200) {
      await CacheService.remove('recommendedMovies');
      return "Success: successfully added movie to list";
    } else {
      return "Error: An error occurred ${response.statusCode}";
    }

  } catch (e) {
    log("Error while fetching watchlist: $e");
    return "Error: An error occurred";
  }
}

Future<WatchListItem?> findMovieInWatchlist(int movieId) async{
  try {
    final firebaseUid = getUserId();
    if (firebaseUid == null) {
      log("Error: Failed to get userID");
      throw "Failed to get userID";
    }

    final url = Uri.parse("$API_URL/user/find_movie_in_watchlist/$firebaseUid/$movieId");
    final headers = await getHeaders();

    log("Finding movie at watchlist at $url");
    final response = await http.get(url, headers: headers);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final watchListData = data['data'];
      if(watchListData == null) {
        return null;
      } else {
        WatchListItem watchListItem = WatchListItem.fromJson(data['data']);
        return watchListItem;
      }
    } else {
      print("Error: An error occurred ${response.statusCode}");
      return null;
    }

  } catch (e) {
    log("Error while fetching watchlist: $e");
    return null;
  }
}

Future<UserStatistic> getUserStatistic() async{
  try {
    final firebaseUid = getUserId();
    if (firebaseUid == null) {
      log("Error: Failed to get userID");
      throw "Failed to get userID";
    }

    final url = Uri.parse("$API_URL/user/get_user_statistics/$firebaseUid");
    final headers = await getHeaders();

    log("Fetching user statistic at $url");
    final response = await http.get(url, headers: headers);
    final responseJson = jsonDecode(response.body);
    final data = responseJson['data'];

    return UserStatistic(minutesWatched: data['minutes_watched'], completedCount: data['completed_count'], plannedCount: data['planned_count'], watchingCount: data['watching_count']);

  } catch (e) {
    log("Error while fetching watchlist: $e");
    return UserStatistic(minutesWatched: 0, completedCount: 0, plannedCount: 0, watchingCount: 0);
  }
}
