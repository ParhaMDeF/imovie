import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:imovie/data/app_exceptions.dart';
import 'package:imovie/data/network/BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse({String? url, Map<String, dynamic>? params}) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.https(url!, "", params));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.statusCode.toString());
      case 404:
        throw UnauthorisedException(response.statusCode.toString());
      case 500:
      default:
        throw FetchDataException(
            "Error accured while communicating with server with status code: ${response.statusCode}");
    }
  }
}
