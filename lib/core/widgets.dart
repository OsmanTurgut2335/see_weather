import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:see_weather/views/astro_view.dart';
import 'package:see_weather/views/currentweather_view.dart';



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

class MatchDetailCard extends StatelessWidget {
  const MatchDetailCard({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text("$title : $value ", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

  Card CustomCard(String text,bool isNight) {
    if (isNight) {
      return Card(color: Color(0xffa982bd), child: Center(child: Text(text, style: TextStyles().textStyle)));
    } else {
      return Card(color: Color(0xffa7a5a8), child: Center(child: Text(text, style: TextStyles().textStyle)));
    }
  }