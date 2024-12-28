import 'package:flutter/material.dart';
import 'package:see_weather/views/astro_view.dart';
import 'package:see_weather/views/currentweather_view.dart';
import 'package:see_weather/views/sports_view.dart';

class HomePageView extends StatelessWidget {
  HomePageView({super.key});

  final List<String> _items = [
    "London",
    "Paris",
    "Ottawa",
    "Brussels",
    "Tokyo",
    "İstanbul",
    "Cairo",
    "Moscow",
    "Helsinki",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Screen", style: TextStyle().copyWith(fontStyle: FontStyle.italic)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Center(child: Text(_items[index])),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AstroView(cityName: _items[index])),
                              //  MaterialPageRoute(builder: (context) => CurrentweatherScreen(city: _items[index])),
                            );
                          },
                          child: Text("ASTRO"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              // MaterialPageRoute(builder: (context) => AstroView(cityName: _items[index])),
                              MaterialPageRoute(builder: (context) => CurrentweatherScreen(city: _items[index])),
                            );
                          },
                          child: Text("WEATHER"),
                        ),
                          TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                            
                              MaterialPageRoute(builder: (context) => SportsView(city: _items[index])),
                            );
                          },
                          child: Text("SPORTS"),
                        ),
                      ],
                    ),
             
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Click on the related fields to see details",
              style: TextStyle().copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
