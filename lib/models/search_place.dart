class SearchPlace {
  int count;
  List<PlaceInfo> list;

  SearchPlace({
    required this.count,
    required this.list,
  });

  factory SearchPlace.fromJson(Map<String, dynamic> json) => SearchPlace(
        count: json["count"] ?? 0,
        list: List<PlaceInfo>.from(
            json["list"]?.map((x) => PlaceInfo.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class PlaceInfo {
  int id;
  String name;
  Coord coord;
  Sys sys;

  PlaceInfo({
    required this.id,
    required this.name,
    required this.coord,
    required this.sys,
  });

  factory PlaceInfo.fromJson(Map<String, dynamic> json) => PlaceInfo(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        sys: Sys.fromJson(json["sys"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord.toJson(),
        "sys": sys.toJson(),
      };
}

class Coord {
  double lat;
  double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Sys {
  String country;

  Sys({required this.country});

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}
