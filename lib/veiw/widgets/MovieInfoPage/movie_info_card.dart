import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imovie/veiw/widgets/MovieInfoPage/rating_widget.dart';

class MovieInfoCard extends StatelessWidget {
  const MovieInfoCard({
    Key? key,
    required this.movieName,
    required this.year,
    required this.genre,
  }) : super(key: key);

  final String movieName;
  final String year;
  final String genre;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                color: Colors.grey.shade200.withOpacity(0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Flexible(
                          child: Text(movieName,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(width: 8),
                      Text(year,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white70))
                    ]),
                    const SizedBox(height: 10),
                    Text(genre,
                        style: const TextStyle(
                            fontSize: 18, color: Colors.white70)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        RatingWidget(title: "IMDB", score: "7.6/10"),
                        RatingWidget(title: "IMDB", score: "98%"),
                        RatingWidget(title: "Overall", score: "99%"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
