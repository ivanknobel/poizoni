import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class HospitalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FlutterMap(
          options: new MapOptions(
            center:  new LatLng(35.22, -101.83), minZoom: 5.0),
        layers: [
          new TileLayerOptions(
            urlTemplate:
            "https://api.mapbox.com/styles/v1/m0ntem0r/ckdom3fl00jgi1io6dqdxmvf7/wmts?access_token=pk.eyJ1IjoibTBudGVtMHIiLCJhIjoiY2tkb3EzOW0xMWx2MjMwbDU5bngyemtuYyJ9.Sm0zWgxEkOZjr1VKQX4ynQ",
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoibTBudGVtMHIiLCJhIjoiY2tkb3EzOW0xMWx2MjMwbDU5bngyemtuYyJ9.Sm0zWgxEkOZjr1VKQX4ynQ',
            'id': 'mapbox.mapbox-streets-v7'
          }),
        new MarkerLayerOptions(markers: [
          new Marker(
            width: 45.0,
            height: 45.0,
              point: new LatLng(35.215, -101.825),
              builder: (context) => new Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.blue,
                  iconSize: 45.0,
                  onPressed: () {
                    print('Marker tapped');
                  },
                ),
              ))
        ])
        ]));
  }
}