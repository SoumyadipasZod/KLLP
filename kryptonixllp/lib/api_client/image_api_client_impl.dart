import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../configure/network_client/network_client_impl.dart';
import '../../configure/status.dart';
import '../../model/image_model.dart';
import '../api_constant/url_constant.dart';
import '../configure/resource.dart';
import 'image_api_client.dart';

class ImageApiClientImpl extends ImageApiClient {
  late NetworkClientImpl _networkClient;

  @override
  Future<Resource> getImages(
      {String? q, String? image_type, int? page, int? per_page}) async {
    try {
      Map<String, dynamic>? params = {};
      String? finalUrl;
      var accessKey = dotenv.env['API_KEY'];

      if (page != null) {
        params.addAll({'page': page.toString()});
      }
      if (q != null && q.isNotEmpty) {
        params.addAll({'query': q.toString()});
      } else {
        if (per_page != null) {
          params.addAll({'per_page': per_page.toString()});
        }
      }

      if (q != null && q.isNotEmpty) {
        finalUrl = searchUrl;
      } else {
        finalUrl = imageUrl;
      }
      String queryString = Uri(queryParameters: params).query;
      String apiUrl =
          queryString.isNotEmpty ? '$finalUrl?$queryString' : finalUrl;
      var response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization':
            'Client-ID $accessKey',
        'Content-Type': 'application/json',
      });
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        String resp = response.body;
        final decodedData = jsonDecode(resp);
        List<ImageModel> images = [];
        images.clear();
        if (decodedData is Map) {
          images = (decodedData['results'] as List)
              .map((item) => ImageModel.fromJson(item))
              .toList();
        } else {
          images = (decodedData as List)
              .map((item) => ImageModel.fromJson(item))
              .toList();
        }
        return Resource(
            status: STATUS.SUCCESS,
            data: images,
            message: 'SuccessFully Data Fetched');
      } else {
        return Resource(
            status: STATUS.ERROR,
            message:
                _networkClient!.getHttpErrorMessage(statusCode: statusCode),
            data: null);
      }
    } catch (ex) {
      if (ex is SocketException) {
        return Resource(
            status: STATUS.ERROR,
            message: 'Please check your internet connection!');
      } else {
        return Resource(status: STATUS.ERROR, message: 'Something went wrong');
      }
    }
  }
}
