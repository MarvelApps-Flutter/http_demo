import 'dart:convert';
import 'dart:developer';

import 'package:http_movies_app/Constants/api_url.dart';
import 'package:http_movies_app/Models/guest_token_id_response_model.dart';
import 'package:http_movies_app/Models/movie_details.dart';
import 'package:http_movies_app/Models/playing_now_model.dart';
import 'package:http_movies_app/Models/popular_movies.dart';
import 'package:http_movies_app/Models/top_rated.dart';

import 'package:http/http.dart' as http;
import 'package:http_movies_app/Models/upcoming_movies.dart';

class APIFunctions {
  Future<TopRatedMoviesResponseModel> getTopRatedMovies() async {
    //TopRatedMoviesResponseModel movies;
    final res = await http.get(
      Uri.parse(TOP_RATED_API_URL),
    );

    if (res.statusCode == 200) {
      //log(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      TopRatedMoviesResponseModel movies =
          TopRatedMoviesResponseModel.fromJson(jsonData);

      return movies;
    } else {
      return jsonDecode(res.body);
    }
  }

  // For popular movies
  Future<PopularMoviesResponseModel> getPopularMovies() async {
    //TopRatedMoviesResponseModel movies;
    final res = await http.get(
      Uri.parse(POPULAR_MOVIES_API_URL),
    );

    if (res.statusCode == 200) {
      //log(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      PopularMoviesResponseModel movies =
          PopularMoviesResponseModel.fromJson(jsonData);

      return movies;
    } else {
      return jsonDecode(res.body);
    }
  }

  // For upcoming movies
  Future<UpcomingMoviesResponseModel> getUpcomingMovies() async {
    //TopRatedMoviesResponseModel movies;
    final res = await http.get(
      Uri.parse(UPCOMING_MOVIES_API_URL),
    );

    if (res.statusCode == 200) {
      //log(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      UpcomingMoviesResponseModel movies =
          UpcomingMoviesResponseModel.fromJson(jsonData);

      return movies;
    } else {
      return jsonDecode(res.body);
    }
  }

  // For upcoming movies
  Future<PlayingNowMoviesResponseModel> getPlayingNowMovies() async {
    //TopRatedMoviesResponseModel movies;
    final res = await http.get(
      Uri.parse(PLAYING_NOW_API_URL),
    );

    if (res.statusCode == 200) {
      //log(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      PlayingNowMoviesResponseModel movies =
          PlayingNowMoviesResponseModel.fromJson(jsonData);

      return movies;
    } else {
      return jsonDecode(res.body);
    }
  }

  // https://api.themoviedb.org/3/movie/{movie_id}?api_key=89625f75e903e0e64ec55732960b6610&language=en-US

  // For movie details
  Future<DetailedMoviesResponseModel> getMovieDetails(int id) async {
    //TopRatedMoviesResponseModel movies;
    String apiUrl =
        "https://api.themoviedb.org/3/movie/$id?api_key=89625f75e903e0e64ec55732960b6610&language=en-US";
    final res = await http.get(
      Uri.parse(apiUrl),
    );

    if (res.statusCode == 200) {
      //log(jsonDecode(res.body));
      var jsonData = jsonDecode(res.body);
      DetailedMoviesResponseModel movies =
          DetailedMoviesResponseModel.fromJson(jsonData);

      return movies;
    } else {
      return jsonDecode(res.body);
    }
  }

  // Post rating

  Future<int> updateMovieRating(int id, String value) async {
    //TopRatedMoviesResponseModel movies;
    String guestSession;
    // String guestSessionApiUrl =
    //     "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=89625f75e903e0e64ec55732960b6610";

    final resGuestToken = await http.get(Uri.parse(GUEST_TOKEN_ID_API_URL));
    var guestJsonDecode = jsonDecode(resGuestToken.body);
    GuestTokenIdResponseModel guestToken =
        GuestTokenIdResponseModel.fromJson(guestJsonDecode);

    guestSession = guestToken.guestSessionId!;

    String apiUrl =
        "https://api.themoviedb.org/3/movie/$id/rating?api_key=89625f75e903e0e64ec55732960b6610&guest_session_id=$guestSession";
    final res = await http
        .post(Uri.parse(apiUrl), body: <String, dynamic>{"value": value});

    if (res.statusCode == 201) {
      //log(jsonDecode(res.body));
      // var jsonData = jsonDecode(res.body);
      // DetailedMoviesResponseModel movies =
      //     DetailedMoviesResponseModel.fromJson(jsonData);

      return res.statusCode;
    } else {
      return res.statusCode;
    }
  }
}
