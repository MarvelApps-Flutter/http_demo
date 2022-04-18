import 'package:flutter/material.dart';

class DataConstants {
  // App Title
  static const String appTitle = "Movies App";

  static const String okay = "Okay";
  static const String ratingUpdateSuccess =
      "Successfully added the ratings. Thanks for your feedback.";
  static const String ratingUpdateFailed =
      "Something went wrong. Please try again with only a multiple of 0.50.";
  static const String rateHere = "Rate Here";
  static const String updateRating = "Update Rating: ";
  static const String averageRating = "Average Rating: ";
  static const String onTen = " /10";
  static const String genre = "Genre: ";
  static const String releasedOn = "Released On: ";
  static const String topRated = "Top Rated";
  static const String popular = "Popular";
  static const String genresHeading = "Genres";
  static const String upcomingMovies = "Upcoming Movies";
  static const String playingNow = "Playing Now";

  static const String imageUrlPrefix = "https://image.tmdb.org/t/p/original";

  List<Color> colors = [
    Colors.red,
    Colors.blue.shade400,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.orange
  ];

  List<String> genres = [
    "Action",
    "Thriller",
    "Adventure",
    "Horror",
    "Comedy",
    "Kids"
  ];
}
