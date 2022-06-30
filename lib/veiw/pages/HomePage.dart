import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imovie/veiw/widgets/HomaPage/loading_widget.dart';
import 'package:imovie/veiw/widgets/HomaPage/movie_card.dart';
import 'package:imovie/view_model/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var future;
  var viewModel = Get.put(HomePageViewModel());
  String query = "";
  Timer? searchOnStoppedTyping;

  void onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = Timer(duration, () {
      setState(() {
        future = viewModel.searchMovie(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: Colors.grey.shade200,
                            spreadRadius: 0.7,
                            blurRadius: 20),
                        BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.grey.shade200,
                            spreadRadius: 0.7,
                            blurRadius: 20),
                      ]),
                  child: TextField(
                    onChanged: (value) {
                      query = value;
                      onChangeHandler(value);
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 15),
                        border: InputBorder.none,
                        prefixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.search,
                              size: 22, color: Theme.of(context).primaryColor),
                          onPressed: () {
                            setState(() {
                              future = viewModel.searchMovie(query);
                            });
                          },
                        )),
                  ),
                ),
                const SizedBox(height: 30),
                FutureBuilder(
                  future: future,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.response == "False") {
                          return SizedBox(
                              height: Get.height * 0.65,
                              child: Center(
                                child: Text('Nothing found!',
                                    style:
                                        Theme.of(context).textTheme.headline3),
                              ));
                        } else {
                          var data = snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  "Search Result (${data?.search?.length ?? 0})",
                                  style: Theme.of(context).textTheme.headline1),
                              SizedBox(
                                height: data!.search!.length.toDouble() * 180.0,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: data.search?.length ?? 0,
                                  itemBuilder: (context, index) => MovieCard(
                                    movieName: data.search![index].title!,
                                    genre: data.search![index].type!,
                                    imageUrl: data.search![index].poster!,
                                    year: data.search![index].year!,
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      }
                    }
                    return const SizedBox();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
