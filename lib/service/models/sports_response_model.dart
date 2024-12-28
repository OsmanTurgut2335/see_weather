class SportResponseModel {
  List<Football>? football;

  SportResponseModel({this.football});

  SportResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['football'] != null) {
      football = <Football>[];
      json['football'].forEach((v) {
        football!.add(new Football.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.football != null) {
      data['football'] = this.football!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Football {
  String? stadium;
  String? country;
  String? region;
  String? tournament;
  String? start;
  String? match;

  Football(
      {this.stadium,
      this.country,
      this.region,
      this.tournament,
      this.start,
      this.match});

  Football.fromJson(Map<String, dynamic> json) {
    stadium = json['stadium'];
    country = json['country'];
    region = json['region'];
    tournament = json['tournament'];
    start = json['start'];
    match = json['match'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stadium'] = this.stadium;
    data['country'] = this.country;
    data['region'] = this.region;
    data['tournament'] = this.tournament;
    data['start'] = this.start;
    data['match'] = this.match;
    return data;
  }
}