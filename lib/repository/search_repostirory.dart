import 'package:imovie/data/network/BaseApiServices.dart';
import 'package:imovie/data/network/NetworkApiService.dart';

class SearchRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  final String baseUrl = "www.omdbapi.com";
  final String apiKey = "2dfb3a8c";
  Future<dynamic> search(String query) async {
    try {
      Map<String, dynamic> params = {"s": query, "apiKey": apiKey};
      dynamic response =
          await _apiServices.getGetApiResponse(url: baseUrl, params: params);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
