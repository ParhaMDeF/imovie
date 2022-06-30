import 'package:imovie/models/searchResultModel.dart';
import 'package:imovie/repository/search_repostirory.dart';
import 'package:get/get.dart';

class HomePageViewModel extends GetxController {
  final _repository = SearchRepository();

  Future<SearchResultModel> searchMovie(String query) async {
    late SearchResultModel resultData;
    await _repository.search(query).then((value) {
      resultData = SearchResultModel.fromJson(value);
    }).onError((error, stackTrace) {
      resultData = SearchResultModel(response: "False");
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: error.toString(),
        duration: const Duration(seconds: 2),
      ));
    });
    return resultData;
  }
  
}
