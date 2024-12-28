import 'dart:io';

import 'package:dio/dio.dart';
import 'package:see_weather/service/models/sports_response_model.dart';

class SportsService {
  final Dio _dio;

  SportsService() : _dio = Dio(BaseOptions(baseUrl: "http://api.weatherapi.com/v1/"));

  Future<SportResponseModel?> fetchCityMatches(String location) async {
    // Define query parameters

    final Map<String, dynamic> queryParams = {'key': '3950ea37ac7d4b63937133613242910', 'q': location};

    try {
      final response = await _dio.get(_SportServicePaths.sportsJson.path, queryParameters: queryParams);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          // Parse data into WeatherResponse
          // print("${data.values}");
          return SportResponseModel.fromJson(data);
        }
      }
    } on DioError catch (exception) {
      // Handle Dio errors
      print("Error fetching weather: ${exception.message}");
    }
    return null; // Return null on failure
  }

  Future<List<SportResponseModel>?> fetchCityMatchesAdvanced(String location) async {
    // Define query parameters

    final Map<String, dynamic> queryParams = {'key': '3950ea37ac7d4b63937133613242910', 'q': location};

    try {
      final response = await _dio.get(_SportServicePaths.sportsJson.path, queryParameters: queryParams);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          //gelen listeyi yeni bir liste yapıyoruz
          print("YARRRRRRRRRRRRAK");
          return List.empty();
        }
      }
    } on DioError catch (exception) {
      // Handle Dio errors
      print("Error fetching weather: ${exception.message}");
    }
    return List.empty(); // Return null on failure
  }
}

enum _SportServicePaths { sportsJson }

extension _SportServicePathsExtension on _SportServicePaths {
  String get path {
    switch (this) {
      case _SportServicePaths.sportsJson:
        return 'sports.json';
    }
  }
}
