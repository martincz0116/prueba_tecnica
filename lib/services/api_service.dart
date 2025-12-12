import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:intl/intl.dart';

final dio = Dio();

Future<String> getRequest(Map<String, dynamic> extraParams) async {
  Map<String, dynamic> queryParams = {
    "api_key": "KwwJQywZSw2HAxfFE3SGpSGGWiYP9PFJXj2fbqTD",
    ...extraParams,
  };
  Response res = await dio.get(
    'https://api.nasa.gov/planetary/apod',
    queryParameters: queryParams,
  );

  if (res.statusCode != 200) {
    throw Exception('Failed to load post');
  }

  return json.encode(res.data);
}

class ApiService {
  Future<List<ApodList>> getApodList() async {
    try {
      DateTime now = DateTime.now();
      DateTime initDate = now.subtract(Duration(days: 10));
      String data = await getRequest({
        "start_date": DateFormat('yyyy-MM-dd').format(initDate),
        "end_date": DateFormat('yyyy-MM-dd').format(now),
      });

      return apodListFromJson(data);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
