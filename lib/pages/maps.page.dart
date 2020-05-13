import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:mapssample/models/map_card_content.model.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(-3.7312299, -38.5145749);
  Set<Marker> _markers = new Set<Marker>();
  List<MapCardContent> _restaurantItems = new List<MapCardContent>();
  String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle
        .loadString('assets/maps/map_style.txt')
        .then((style) => _mapStyle = style);

    _restaurantItems.add(new MapCardContent(
      location: LatLng(-3.7332731, -38.5080403),
      restaurantName: "ALDEOTA RESTAURANT",
      restaurantImage: "assets/images/restaurant01.jpg",
      restaurantIcon: "assets/images/generic_icon.png",
      restaurantDistance: 0.5,
      restaurantStars: 5.0,
    ));

    _restaurantItems.add(new MapCardContent(
      location: LatLng(-3.7308829, -38.5150275),
      restaurantName: "FORTALEZA RESTAURANT",
      restaurantImage: "assets/images/restaurant02.jpg",
      restaurantIcon: "assets/images/generic_icon.png",
      restaurantDistance: 0.5,
      restaurantStars: 5.0,
    ));

    _restaurantItems.add(new MapCardContent(
      location: LatLng(-3.7395977, -38.5216391),
      restaurantName: "IRACEMA RESTAURANT",
      restaurantImage: "assets/images/restaurant03.jpg",
      restaurantIcon: "assets/images/generic_icon.png",
      restaurantDistance: 0.5,
      restaurantStars: 5.0,
    ));

    _restaurantItems.forEach((item) {
      _markers.add(
        new Marker(
          markerId: MarkerId('test'),
          position: item.location,
          infoWindow: InfoWindow(title: item.restaurantName),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            44.0,
          ),
        ),
      );
    });
  }

  _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    _controller.complete(controller);
  }

  Widget _buildTopGradient({@required Size size}) {
    return Container(
      height: size.height * 0.25,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(255, 255, 255, 0.999),
            Color.fromRGBO(255, 255, 255, 0),
          ],
        ),
      ),
    );
  }

  Widget _buildEndGradient({@required Size size}) {
    return Container(
      height: size.height * 0.12,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(255, 255, 255, 0.999),
            Color.fromRGBO(255, 255, 255, 0),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch({@required Size size}) {
    return Container(
      height: size.height * 0.091,
      width: size.width,
      decoration: ShapeDecoration(
        shadows: [
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(1.0, 1.0),
          ),
        ],
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          width: size.width * 0.92,
          height: size.height * 0.068,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TextField(
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: size.height * 0.045,
                      ),
                      border: InputBorder.none,
                      hintText: "Digite seu Bairro, CEP...",
                      hintStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[800],
                      ),
                      fillColor: Colors.grey[800],
                      contentPadding: EdgeInsets.only(top: 10.5),
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                indent: 7.0,
                endIndent: 7.0,
                color: Colors.grey[600],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                child: Container(
                  height: 40,
                  width: 30,
                  child: Material(
                    color: Colors.grey[100],
                    child: InkWell(
                      onTap: () => {},
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      child: Icon(
                        Icons.tune,
                        color: Colors.black,
                        size: size.height * 0.029,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      {@required bool isFirstItem,
      @required bool isLastItem,
      @required Size size,
      @required MapCardContent restaurantItem}) {
    double borderRadius = 15.0;

    return Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.020,
        left: isFirstItem ? size.width * 0.038 : size.width * 0.01,
        right: isLastItem ? size.width * 0.038 : 0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: Stack(
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
              onTap: () => {_goToLocation(location: restaurantItem.location)},
              child: Container(
                width: size.width * 0.78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: size.height * 0.12,
                      width: size.width * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                        ),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.hardLight,
                          ),
                          fit: BoxFit.cover,
                          image: AssetImage(restaurantItem.restaurantImage),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              top: 35.0,
                              left: 7.0,
                            ),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage(restaurantItem.restaurantIcon),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              restaurantItem.restaurantName,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${restaurantItem.restaurantDistance}km",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 4.0, left: 10.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    "${restaurantItem.restaurantStars}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: size.width * 0.67),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () => {},
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _goToLocation({@required LatLng location}) async {
    final GoogleMapController mapController = await _controller.future;

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 18, tilt: 50.0, bearing: 45.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            width: size.width,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 13.5,
              ),
              markers: _markers,
            ),
          ),
          _buildTopGradient(size: size),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _buildEndGradient(size: size),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.090,
              left: size.width * 0.042,
              right: size.width * 0.042,
            ),
            child: _buildSearch(size: size),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height * 0.18,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: size.height * 0.031,
                  ),
                  child: Container(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _restaurantItems.length,
                      itemBuilder: (context, index) {
                        return _buildItem(
                          isFirstItem: index == 0,
                          isLastItem: index == (_restaurantItems.length - 1),
                          size: size,
                          restaurantItem: _restaurantItems[index],
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
