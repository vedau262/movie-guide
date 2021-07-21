class FootballMatch {
  String? first;
  String? second;
  Match? match;

  FootballMatch(this.first, this.second, this.match);

  FootballMatch.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    second = json['second'];
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['second'] = this.second;
    if (this.match != null) {
      data['match'] = this.match!.toJson();
    }
    return data;
  }
}

class Match {
  int? first = 0;
  int? second = 0;

  Match({this.first, this.second});

  Match.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['second'] = this.second;
    return data;
  }
}