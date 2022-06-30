import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imovie/veiw/widgets/movie_card.dart';
import 'package:imovie/view_model/home_page_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var future;
  var viewModel = Get.put(HomePageViewModel());
  String query = "";
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
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    onChanged: (value) => query = value,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
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
                      return SizedBox(
                        height: Get.height * 0.6,
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: Theme.of(context).primaryColor, size: 40),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.response == "False") {
                          return SizedBox(
                              height: Get.height * 0.6,
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
