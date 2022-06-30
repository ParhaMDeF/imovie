import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:imovie/pages/MovieInfoPage.dart';

class MovieCard extends StatelessWidget {
  final String movieName, genre, imageUrl, year;
  const MovieCard({
    Key? key,
    required this.movieName,
    required this.genre,
    required this.imageUrl,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Get.to(() => MovieInfoPage(
            imageUrl: imageUrl,
            genre: genre,
            movieName: movieName,
            year: year,
          ))),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SizedBox(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: imageUrl,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.fill,
                    )),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movieName,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.headline2),
                      const SizedBox(height: 10),
                      Text(
                        genre,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const Spacer(),
                      RatingBarIndicator(
                        rating: 3,
                        unratedColor: const Color(0xFFE0E2E7),
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
