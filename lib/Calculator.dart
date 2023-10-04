import 'dart:math';

import 'Models/Locationn.dart';

class Calculator{


  //////////////////////////////////////////////////
  static double calculateDistance(Locationn location1, Locationn location2) {
    return sqrt(pow(location1.x - location2.x, 2) + pow(location1.y - location2.y, 2));
  }

  static List<Locationn> nearestNeighbor(List<Locationn> locations) {
    if (locations.isEmpty) {
      return [];
    }

     List<Locationn> path = [locations.first];
      List<Locationn> unvisitedLocations = List.from(locations)..removeAt(0);

    while (unvisitedLocations.isNotEmpty) {
      Locationn currentLocation = path.last;
      Locationn nearestLocation = unvisitedLocations.reduce((a, b) =>
      calculateDistance(currentLocation, a) < calculateDistance(currentLocation, b) ? a : b);
      path.add(nearestLocation);
      unvisitedLocations.remove(nearestLocation);
    }

    return path;
  }

  static double calculateDistance2(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }



}