import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCardContent {
  MapCardContent({
    @required this.location,
    @required this.restaurantName,
    @required this.restaurantIcon,
    @required this.restaurantImage,
    @required this.restaurantStars,
    @required this.restaurantDistance,
  });

  LatLng location;
  String restaurantName;
  String restaurantIcon;
  String restaurantImage;
  double restaurantStars;
  double restaurantDistance;
}
