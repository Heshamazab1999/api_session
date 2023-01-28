class WeatherModel {
  final LocationModel? location;

  // final CurrentModel? current;

  WeatherModel({
    this.location,
    // this.current
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: LocationModel.fromJson(json["location"]),
    );
  }
}

class LocationModel {
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? tz_id;
  final String? localtime;
  final int? localtime_epoch;

  LocationModel(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.localtime,
      this.localtime_epoch,
      this.lon,
      this.tz_id});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        lat: json["lat"],
        country: json["country"],
        localtime: json["localtime"],
        localtime_epoch: json["localtime_epoch"],
        lon: json["lon"],
        name: json["name"],
        region: json["region"],
        tz_id: json["tz_id"]);
  }
}

class CurrentModel {
  final int? temp_c;
  final double? temp_f;
  final ConditionModel? condition;

  CurrentModel({this.temp_c, this.temp_f, this.condition});

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
        temp_c: json["temp_c"],
        temp_f: json["temp_f"],
        condition: ConditionModel.fromJson(json["condition"]));
  }
}

class ConditionModel {
  final String? text;
  final String? icon;

  ConditionModel({this.text, this.icon});

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(text: json["text"], icon: json["icon"]);
  }
}
