class WeatherResponse {
  final Location location;
  final Current current;

  WeatherResponse({required this.location, required this.current});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(location: Location.fromJson(json['location']), current: Current.fromJson(json['current']));
  }
}

class Location {
  final String name;
  final String country;

  Location({required this.name, required this.country});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json['name'], country: json['country']);
  }
}

class Current {
  final double tempC;
  final Condition condition;

  Current({required this.tempC, required this.condition});

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(tempC: json['temp_c'].toDouble(), condition: Condition.fromJson(json['condition']));
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(text: json['text'], icon: json['icon']);
  }
}
