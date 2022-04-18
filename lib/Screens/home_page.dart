import 'package:flutter/material.dart';
import 'package:http_movies_app/Constants/static_data_constants.dart';
import 'package:http_movies_app/Models/genres_response_model.dart';
import 'package:http_movies_app/Models/playing_now_model.dart';
import 'package:http_movies_app/Models/popular_movies.dart';
import 'package:http_movies_app/Models/top_rated.dart';
import 'package:http_movies_app/Models/upcoming_movies.dart';
import 'package:http_movies_app/Screens/movie_details_page.dart';
import 'package:http_movies_app/Services/api_functions.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIFunctions apiFunctions = APIFunctions();
  List<bool> heartTapped = [false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(2, 34, 60, 0.5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(2, 34, 60, 1),
        title: const Text(
          DataConstants.appTitle,
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingText(DataConstants.topRated, context),
            Container(),
            carouselWidgetTopRated(
                MediaQuery.of(context).size.height * 0.4, 270),
            headingText(DataConstants.popular, context),
            carouselWidgetPopular(
                MediaQuery.of(context).size.height * 0.30, 210),
            headingText(DataConstants.genresHeading, context),
            //carouselWidget(MediaQuery.of(context).size.height * 0.10, 200)
            genresWidget(MediaQuery.of(context).size.height * 0.07, 200),
            headingText(DataConstants.upcomingMovies, context),
            carouselWidgetUpcoming(
                MediaQuery.of(context).size.height * 0.25, 150),
            headingText(DataConstants.playingNow, context),
            carouselWidgetPlayingNow(
                MediaQuery.of(context).size.height * 0.25, 150),
          ],
        ),
      ),
    );
  }

  Widget carouselWidgetTopRated(double heightOfContainer, double itemExtent) {
    return Container(
        height: heightOfContainer,
        child: InfiniteCarousel.builder(
            itemCount: 10,
            itemExtent: itemExtent,
            //380,
            itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(8)),
                child: Card(
                    color: Theme.of(context).primaryColor,
                    child: FutureBuilder(
                        future: apiFunctions.getTopRatedMovies(),
                        builder: (BuildContext context,
                            AsyncSnapshot<TopRatedMoviesResponseModel>
                                snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? snapshot.hasData
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsPage(
                                                      movieId: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .id!,
                                                      title: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .originalTitle!)),
                                        );
                                      },
                                      child: Image.network(
                                        DataConstants.imageUrlPrefix +
                                            snapshot.data!.results![itemIndex]
                                                .posterPath!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.movie,
                                      color: Colors.white,
                                    )
                              : const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                );
                        })),
              );
            }));
  }

  Widget carouselWidgetPopular(double heightOfContainer, double itemExtent) {
    return Container(
        height: heightOfContainer,
        child: InfiniteCarousel.builder(
            itemCount: 10,
            itemExtent: itemExtent,
            //380,
            itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(8)),
                child: Card(
                    color: Theme.of(context).primaryColor,
                    child: FutureBuilder(
                        future: apiFunctions.getPopularMovies(),
                        builder: (BuildContext context,
                            AsyncSnapshot<PopularMoviesResponseModel>
                                snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? snapshot.hasData
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsPage(
                                                      movieId: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .id!,
                                                      title: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .originalTitle!)),
                                        );
                                      },
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/original" +
                                            snapshot.data!.results![itemIndex]
                                                .posterPath!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.movie,
                                      color: Colors.white,
                                    )
                              : const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                );
                        })),
              );
            }));
  }

  Widget carouselWidgetUpcoming(double heightOfContainer, double itemExtent) {
    return Container(
        height: heightOfContainer,
        child: InfiniteCarousel.builder(
            itemCount: 10,
            itemExtent: itemExtent,
            //380,
            itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(8)),
                child: Card(
                    color: Theme.of(context).primaryColor,
                    child: FutureBuilder(
                        future: apiFunctions.getUpcomingMovies(),
                        builder: (BuildContext context,
                            AsyncSnapshot<UpcomingMoviesResponseModel>
                                snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? snapshot.hasData
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsPage(
                                                      movieId: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .id!,
                                                      title: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .originalTitle!)),
                                        );
                                      },
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/original" +
                                            snapshot.data!.results![itemIndex]
                                                .posterPath!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.movie,
                                      color: Colors.white,
                                    )
                              : const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                );
                        })),
              );
            }));
  }

  Widget carouselWidgetPlayingNow(double heightOfContainer, double itemExtent) {
    return Container(
        height: heightOfContainer,
        child: InfiniteCarousel.builder(
            itemCount: 10,
            itemExtent: itemExtent,
            //380,
            itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(8)),
                child: Card(
                    color: Theme.of(context).primaryColor,
                    child: FutureBuilder(
                        future: apiFunctions.getPlayingNowMovies(),
                        // ignore: dead_code
                        builder: (BuildContext context,
                            AsyncSnapshot<PlayingNowMoviesResponseModel>
                                snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? snapshot.hasData
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsPage(
                                                      movieId: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .id!,
                                                      title: snapshot
                                                          .data!
                                                          .results![itemIndex]
                                                          .originalTitle!)),
                                        );
                                      },
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/original" +
                                            snapshot.data!.results![itemIndex]
                                                .posterPath!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.movie,
                                      color: Colors.white,
                                    )
                              : const Icon(
                                  Icons.movie,
                                  color: Colors.white,
                                );
                        })),
              );
            }));
  }

  Widget carouselWidget(
    double heightOfContainer,
    double itemExtent,
  ) {
    return FutureBuilder(
      future: apiFunctions.getTopRatedMovies(),
      builder: (BuildContext context,
          AsyncSnapshot<TopRatedMoviesResponseModel> snapshot) {
        return snapshot.hasData
            ? Container(
                height: heightOfContainer,
                child: InfiniteCarousel.builder(
                    itemCount: snapshot.data!.results!.length,
                    itemExtent: itemExtent,
                    //380,
                    itemBuilder:
                        (BuildContext context, int itemIndex, int realIndex) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(8)),
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.movie,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }))
            : Container(
                height: heightOfContainer,
                child: InfiniteCarousel.builder(
                    itemCount: 10,
                    itemExtent: itemExtent,
                    //380,
                    itemBuilder:
                        (BuildContext context, int itemIndex, int realIndex) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            //shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(8)),
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: const Icon(
                            Icons.movie,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }));
      },
    );
  }

  Widget genresWidget(double heightOfContainer, double itemExtent) {
    return Container(
        height: 60,
        child: InfiniteCarousel.builder(
            itemCount: 6,
            itemExtent: itemExtent,
            //380,
            itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
              return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: Theme.of(context).primaryColor,
                      //shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      print("Tapped" + genres[itemIndex]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: colors[itemIndex],
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        genres[itemIndex],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ));
            }));
  }

  Widget headingText(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

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
