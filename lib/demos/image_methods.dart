import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:see_weather/views/currentweather_view.dart';


class ImageMethods {

}
class WeatherCustomImage extends StatelessWidget {
  const WeatherCustomImage({super.key, required this.widget});

  final CurrentweatherScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset("assets/png/${widget.city.toLowerCase()}.png", fit: BoxFit.cover, height: 300),
      ),
    );
  }
}