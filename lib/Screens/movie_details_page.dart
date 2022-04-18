import 'package:flutter/material.dart';
import 'package:http_movies_app/Constants/static_data_constants.dart';

import 'package:http_movies_app/Models/movie_details.dart';
import 'package:http_movies_app/Services/api_functions.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String title;

  const MovieDetailsPage({Key? key, required this.movieId, required this.title})
      : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  APIFunctions apiFunctions = APIFunctions();
  TextEditingController ratingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(2, 34, 60, 0.5),
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(2, 34, 60, 1),
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: FutureBuilder(
              future: apiFunctions.getMovieDetails(widget.movieId),
              builder: (BuildContext context,
                  AsyncSnapshot<DetailedMoviesResponseModel> snapshot) {
                return snapshot.hasData
                    ? Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            posterSection(snapshot.data!.posterPath!),
                            titleSection(snapshot.data!.originalTitle!),
                            movieDescriptionSection(snapshot.data!.overview!),
                            releaseSection(snapshot.data!.releaseDate
                                .toString()
                                .split(" ")
                                .first),
                            genreSection(snapshot.data!.genres![0].name!),
                            averageRatingSection(
                                snapshot.data!.voteAverage!.toString()),
                            ratingUpdateSection(),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ));
  }

  Widget ratingUpdateSection() {
    return Row(children: [
      textHeading(DataConstants.updateRating),
      Container(
          height: 30,
          width: 60,
          decoration: const BoxDecoration(color: Colors.white),
          child: TextFormField(
            controller: ratingController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: DataConstants.rateHere,
                hintStyle: TextStyle(color: Colors.white)),
          )),
      const SizedBox(
        width: 10,
      ),
      InkWell(
        onTap: () async {
          int status = await apiFunctions.updateMovieRating(
              widget.movieId, ratingController.text);
          if (status == 201) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              DataConstants.ratingUpdateSuccess,
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              DataConstants.ratingUpdateFailed,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )));
          }
        },
        child: Container(
          height: 30,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(20)),
          child: Text(
            DataConstants.okay,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      )
    ]);
  }

  Widget movieDescriptionSection(String movieDescription) {
    return Text(
      movieDescription,
      textAlign: TextAlign.justify,
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget titleSection(String movieTitle) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        movieTitle,
        style: const TextStyle(
            color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }

  Widget posterSection(String imageUrl) {
    return Card(
      elevation: 2,
      child: Image.network(
        DataConstants.imageUrlPrefix + imageUrl,
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.9,
      ),
    );
  }

  Widget textHeading(String titleText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        titleText,
        style: const TextStyle(
            color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget descriptionText(String description) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        description,
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }

  Widget averageRatingSection(String averageRating) {
    return Row(
      children: [
        textHeading(DataConstants.averageRating),
        descriptionText(averageRating.toString() + DataConstants.onTen)
      ],
    );
  }

  Widget genreSection(String movieGenre) {
    return Row(
      children: [textHeading(DataConstants.genre), descriptionText(movieGenre)],
    );
  }

  Widget releaseSection(String releaseDate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textHeading(DataConstants.releasedOn),
        descriptionText(releaseDate)
      ],
    );
  }
}
