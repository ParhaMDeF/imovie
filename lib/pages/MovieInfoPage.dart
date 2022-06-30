import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imovie/widgets/MovieInfoPage/movie_info_card.dart';

class MovieInfoPage extends StatelessWidget {
  final String imageUrl, movieName, genre, year;
  const MovieInfoPage(
      {super.key,
      required this.imageUrl,
      required this.movieName,
      required this.genre,
      required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fitHeight,
              height: Get.height,
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          Positioned(
            bottom: 70,
            child: MovieInfoCard(movieName: movieName, year: year, genre: genre),
          )
        ],
      ),
    );
  }
}
