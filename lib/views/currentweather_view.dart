import 'package:flutter/material.dart';
import 'package:see_weather/core/widgets.dart';

import 'package:see_weather/service/models/currentweather_model.dart';
import 'package:see_weather/service/weather_service.dart/currentweather_service.dart';

class CurrentweatherScreen extends StatefulWidget {
  final String city;
  const CurrentweatherScreen({super.key, this.city = ""});

  @override
  State<CurrentweatherScreen> createState() => _CurrentweatherScreenState();
}

class _CurrentweatherScreenState extends State<CurrentweatherScreen> {
  late final CurrentWeatherService currentWeatherService;
  WeatherResponse? weatherResponse;
  List<String> weatherDetails = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    currentWeatherService = CurrentWeatherService();
    //fetchCityWeather(widget.city);
    //  adjustResponse();
    loadWeather(widget.city);
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // Usage example
  Future<void> loadWeather(String cityName) async {
    await fetchCityWeather(cityName); // Wait for fetch
    await adjustResponse(); // Then adjust response
  }

  Future<void> fetchCityWeather(String cityName) async {
    _changeLoading();
    weatherResponse = await currentWeatherService.fetchCityWeather(cityName);
    _changeLoading();
  }

  Future<void> adjustResponse() async {
    weatherDetails = [
      //"City: ${weatherResponse?.location.name}",
      "Country: ${weatherResponse?.location.country}",
      "Temperature: ${weatherResponse?.current.tempC}°C",
      "Condition: ${weatherResponse?.current.condition.text}",
      //   "Icon: ${weatherResponse?.current.condition.icon}",
    ];
  }

  String ensureHttpProtocol(String url) {
    if (url.startsWith('//')) {
      return 'https:' + url;
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.city), centerTitle: true),
      body:
          weatherResponse == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),

                    // WeatherCustomImage(widget: widget),
                    WeatherCustomImage(widget: widget),

                    //   weatherImageCustomView(widget.city.toLowerCase()),
                    SizedBox(height: 40),
                    // Görsel Alanı
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 10)],
                      ),
                      child: ClipOval(
                        child: Image.network(ensureHttpProtocol(weatherResponse!.current.condition.icon), height: 100),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Bilgi Alanı
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Ülke Bilgisi
                            Text(
                              "Country: ${weatherResponse!.location.country}",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),

                            CustomDivider(),

                            weatherScreenText("Temperature: ${weatherResponse!.current.tempC}°C"),

                            CustomDivider(),

                            weatherScreenText("Condition : ${weatherResponse!.current.condition.text} "),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: Colors.grey.shade300);
  }
}

Text weatherScreenText(String text) {
  return Text("$text ", style: TextStyle(fontSize: 16));
}

Image weatherImageCustomView(String cityName) {
  return Image.asset("assets/png/$cityName.png", fit: BoxFit.cover, height: 300);
}
