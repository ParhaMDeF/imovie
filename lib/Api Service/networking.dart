import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imovie/models/searchResultModel.dart';
import 'package:get/get.dart';

class Networking extends GetxController {
  final String baseUrl = "www.omdbapi.com";
  final String apiKey = "2dfb3a8c";

  Future<SearchResultModel> searchMovies(String query) async {
    var result;
    Map<String, dynamic> params = {"s": query, "apiKey": apiKey};
    try {
      var url = Uri.https(baseUrl, "", params);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        result = SearchResultModel.fromJson(json.decode(response.body));
      } else {
        Get.showSnackbar(const GetSnackBar(
          title: "Error",
          message: "No internet connection ",
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        title: "Error",
        message: "Oops, something wents wrong! ",
        duration: Duration(seconds: 2),
      ));
    }
    return result;
  }
}
