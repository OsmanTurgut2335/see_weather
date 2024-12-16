import 'package:flutter/material.dart';
import 'package:see_weather/views/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        cardTheme: CardTheme().copyWith(),

        appBarTheme: AppBarTheme().copyWith(centerTitle: true, backgroundColor: Color(0xffded8e6)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
      ),
      home: HomePageView(),
    );
  }
}
