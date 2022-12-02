class PolyModels {
  PolyModels({
    required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });
  late final List<GeocodedWaypoints> geocodedWaypoints;
  late final List<Routes> routes;
  late final String status;

  PolyModels.fromJson(Map<String, dynamic> json) {
    geocodedWaypoints = List.from(json['geocoded_waypoints'])
        .map((e) => GeocodedWaypoints.fromJson(e))
        .toList();
    routes = List.from(json['routes']).map((e) => Routes.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['geocoded_waypoints'] =
        geocodedWaypoints.map((e) => e.toJson()).toList();
    _data['routes'] = routes.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class GeocodedWaypoints {
  GeocodedWaypoints({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });
  late final String geocoderStatus;
  late final String placeId;
  late final List<String> types;

  GeocodedWaypoints.fromJson(Map<String, dynamic> json) {
    geocoderStatus = json['geocoder_status'];
    placeId = json['place_id'];
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['geocoder_status'] = geocoderStatus;
    _data['place_id'] = placeId;
    _data['types'] = types;
    return _data;
  }
}

class Routes {
  Routes({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });
  late final Bounds bounds;
  late final String copyrights;
  late final List<Legs> legs;
  late final OverviewPolyline overviewPolyline;
  late final String summary;
  late final List<dynamic> warnings;
  late final List<dynamic> waypointOrder;

  Routes.fromJson(Map<String, dynamic> json) {
    bounds = Bounds.fromJson(json['bounds']);
    copyrights = json['copyrights'];
    legs = List.from(json['legs']).map((e) => Legs.fromJson(e)).toList();
    overviewPolyline = OverviewPolyline.fromJson(json['overview_polyline']);
    summary = json['summary'];
    warnings = List.castFrom<dynamic, dynamic>(json['warnings']);
    waypointOrder = List.castFrom<dynamic, dynamic>(json['waypoint_order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bounds'] = bounds.toJson();
    _data['copyrights'] = copyrights;
    _data['legs'] = legs.map((e) => e.toJson()).toList();
    _data['overview_polyline'] = overviewPolyline.toJson();
    _data['summary'] = summary;
    _data['warnings'] = warnings;
    _data['waypoint_order'] = waypointOrder;
    return _data;
  }
}

class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });
  late final Northeast northeast;
  late final Southwest southwest;

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = Northeast.fromJson(json['northeast']);
    southwest = Southwest.fromJson(json['southwest']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['northeast'] = northeast.toJson();
    _data['southwest'] = southwest.toJson();
    return _data;
  }
}

class Northeast {
  Northeast({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Southwest {
  Southwest({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Legs {
  Legs({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.trafficSpeedEntry,
    required this.viaWaypoint,
  });
  late final Distance distance;
  late final Duration duration;
  late final String endAddress;
  late final EndLocation endLocation;
  late final String startAddress;
  late final StartLocation startLocation;
  late final List<Steps> steps;
  late final List<dynamic> trafficSpeedEntry;
  late final List<dynamic> viaWaypoint;

  Legs.fromJson(Map<String, dynamic> json) {
    distance = Distance.fromJson(json['distance']);
    duration = Duration.fromJson(json['duration']);
    endAddress = json['end_address'];
    endLocation = EndLocation.fromJson(json['end_location']);
    startAddress = json['start_address'];
    startLocation = StartLocation.fromJson(json['start_location']);
    steps = List.from(json['steps']).map((e) => Steps.fromJson(e)).toList();
    trafficSpeedEntry =
        List.castFrom<dynamic, dynamic>(json['traffic_speed_entry']);
    viaWaypoint = List.castFrom<dynamic, dynamic>(json['via_waypoint']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance.toJson();
    _data['duration'] = duration.toJson();
    _data['end_address'] = endAddress;
    _data['end_location'] = endLocation.toJson();
    _data['start_address'] = startAddress;
    _data['start_location'] = startLocation.toJson();
    _data['steps'] = steps.map((e) => e.toJson()).toList();
    _data['traffic_speed_entry'] = trafficSpeedEntry;
    _data['via_waypoint'] = viaWaypoint;
    return _data;
  }
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });
  late final String text;
  late final int value;

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['value'] = value;
    return _data;
  }
}

class Duration {
  Duration({
    required this.text,
    required this.value,
  });
  late final String text;
  late final int value;

  Duration.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['value'] = value;
    return _data;
  }
}

class EndLocation {
  EndLocation({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  EndLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class StartLocation {
  StartLocation({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  StartLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Steps {
  Steps({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    required this.startLocation,
    required this.travelMode,
  });
  late final Distance distance;
  late final Duration duration;
  late final EndLocation endLocation;
  late final String htmlInstructions;
  late final Polyline polyline;
  late final StartLocation startLocation;
  late final String travelMode;

  Steps.fromJson(Map<String, dynamic> json) {
    distance = Distance.fromJson(json['distance']);
    duration = Duration.fromJson(json['duration']);
    endLocation = EndLocation.fromJson(json['end_location']);
    htmlInstructions = json['html_instructions'];
    polyline = Polyline.fromJson(json['polyline']);
    startLocation = StartLocation.fromJson(json['start_location']);
    travelMode = json['travel_mode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['distance'] = distance.toJson();
    _data['duration'] = duration.toJson();
    _data['end_location'] = endLocation.toJson();
    _data['html_instructions'] = htmlInstructions;
    _data['polyline'] = polyline.toJson();
    _data['start_location'] = startLocation.toJson();
    _data['travel_mode'] = travelMode;
    return _data;
  }
}

class Polyline {
  Polyline({
    required this.points,
  });
  late final String points;

  Polyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['points'] = points;
    return _data;
  }
}

class OverviewPolyline {
  OverviewPolyline({
    required this.points,
  });
  late final String points;

  OverviewPolyline.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['points'] = points;
    return _data;
  }
}
