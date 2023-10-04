import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Calculator.dart';
import '../Models/Locationn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map with Markers',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;


  final LatLng _initialLocation = const LatLng(31.88, 35.85);


  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('marker1'),
      position: LatLng(31.99, 35.94),
      infoWindow: InfoWindow(
        title: 'Marker 1',
        snippet: 'San Francisco',
      ),
    ),
    Marker(
      markerId: MarkerId('marker2'),
      position: LatLng(31.95, 35.83),
      infoWindow: InfoWindow(
        title: 'Marker 2',
        snippet: 'Los Angeles',
      ),
    ),
    // Add more markers as needed
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  List<Locationn> locations = [
    Locationn(31.99, 35.94,'Location A'),   // Location A
    Locationn(31.95, 35.83,'Location B'),   // Location B
    Locationn(31.88, 35.85,'Location C'),   // Location C
    Locationn(32.04, 35.91,'Location D'),   // Location D
    Locationn(32.02, 36.02,'Location E'),   // Location E
    Locationn(32.04, 35.93,'Location F'),   // Location F
  ];

  @override
  void initState() {


    List<Locationn> shortestPath = Calculator.nearestNeighbor(locations);

    double totalDistance = 0;
    for(var i = 0; i < shortestPath.length-1; i++){
      totalDistance += Calculator.calculateDistance2(shortestPath[i].x, shortestPath[i].y, shortestPath[i+1].x, shortestPath[i+1].y);
    }

    print('Shortest path to visit all sites with nearest neighbor algorithm:');
    print(shortestPath.map((location) => '(${location.name})').join(' -> '));
    print('Total distance: $totalDistance');    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Map with Markers'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialLocation,
                zoom: 9.0,
              ),
              markers: _markers,
            ),
          ],
        ),
      ),
    );
  }
}
