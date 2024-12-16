import 'dart:io';

import 'package:dio/dio.dart';
import 'package:see_weather/service/models/astro_response_model.dart';

class AstroService {
  final Dio _dio;

  AstroService() : _dio = Dio(BaseOptions(baseUrl: "http://api.weatherapi.com/v1/"));

  String getDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  Future<AstroResponseModel?> fetchAstroData(String cityName) async {
    String date = getDateTime();
    final Map<String, dynamic> queryParams = {
      'key': '3950ea37ac7d4b63937133613242910',
      'q': cityName.toLowerCase(),
      'dt': date,
    };

    final response = await _dio.get(_AstroServicePaths.astronomyJson.path, queryParameters: queryParams);

    if (response.statusCode == HttpStatus.ok) {
      final data = response.data;

      if (data is Map<String, dynamic>) {
     
        return AstroResponseModel.fromJson(data);
      }
    }
  
  }
}

enum _AstroServicePaths { astronomyJson }

extension WeatherServicePathsExtension on _AstroServicePaths {
  String get path {
    switch (this) {
      case _AstroServicePaths.astronomyJson:
        return 'astronomy.json';
      //   case _WeatherServicePaths.comments:
      //  return 'comments';
    }
  }
}

