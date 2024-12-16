import 'dart:io';

import 'package:dio/dio.dart';
import 'package:see_weather/service/models/currentweather_model.dart';

class CurrentWeatherService {
  final Dio _dio;

  CurrentWeatherService() : _dio = Dio(BaseOptions(baseUrl: "http://api.weatherapi.com/v1/"));

  Future<WeatherResponse?> fetchCityWeather(String location) async {
    // Define query parameters
    final Map<String, dynamic> queryParams = {'key': '3950ea37ac7d4b63937133613242910', 'q': location, 'aqi': "no"};

    try {
      // Send request
      print("YARRAK");
      final response = await _dio.get(_WeatherServicePaths.currentJson.path, queryParameters: queryParams);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          // Parse data into WeatherResponse
         // print("${data.values}");
          return WeatherResponse.fromJson(data);
        }
      }
    } on DioError catch (exception) {
      // Handle Dio errors
      print("Error fetching weather: ${exception.message}");
    }
    return null; // Return null on failure
  }
}

enum _WeatherServicePaths { currentJson, comments }

extension WeatherServicePathsExtension on _WeatherServicePaths {
  String get path {
    switch (this) {
      case _WeatherServicePaths.currentJson:
        return 'current.json';
      case _WeatherServicePaths.comments:
        return 'comments';
    }
  }
}
