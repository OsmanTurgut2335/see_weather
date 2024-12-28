import 'package:flutter/material.dart';
import 'package:see_weather/core/widgets.dart';
import 'package:see_weather/service/models/sports_response_model.dart';
import 'package:see_weather/service/weather_service.dart/sports_service.dart';

class SportsView extends StatefulWidget {
  final String city;

  SportsView({super.key, required this.city});

  @override
  State<SportsView> createState() => _SportsViewState();
}

class _SportsViewState extends State<SportsView> {
  SportResponseModel? matches;

  late List<Widget> matchesList = [];

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    final fetchedMatches = await SportsService().fetchCityMatches(widget.city);
    List<SportResponseModel>? list = await SportsService().fetchCityMatchesAdvanced(widget.city);
    // Update state when matches are fetched
    setState(() {
      matches = fetchedMatches;
      matchesList = convertMatchesToList(matches);
      print(matches.runtimeType);
    });
  }

  List<Widget> convertMatchesToList(SportResponseModel? matches) {
    if (matches == null || matches.football == null) {
      return [Center(child: const Text("No matches found."))];
    }

    return matches.football!.map((football) {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        // decoration: BoxDecoration(color: Colors.blueAccent.shade100, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Match: ${football.match ?? 'Unknown'}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 10,
                children: [
                  MatchDetailCard(title: "Country", value: football.country ?? "Unknown"),
                  MatchDetailCard(title: "Country", value: football.region ?? "Unknown"),
                  MatchDetailCard(title: "Tournament", value: football.tournament ?? "Unknown"),
                  MatchDetailCard(title: "Match Start", value: football.start ?? "Unknown"),
                  MatchDetailCard(title: "Stadium", value: football.stadium ?? "Unknown"),
                ],
              ),
            ),
            Spacer(),
            Text("Swipe  to see other matches "),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Matches in ${widget.city}")),
      body:
          matches == null
              ? const Center(child: CircularProgressIndicator()) // Show loader if data is not yet loaded
              : PageView.builder(
                itemCount: matchesList.length,
                itemBuilder: (context, index) {
                  return matchesList[index];
                },
              ),
    );
  }
}


