import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:poizoni/datas/hospital_data.dart';
import 'package:poizoni/screens/hospital_screen.dart';
import 'package:poizoni/widgets/emergency_button.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.747932, -71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685, -122.0605916);
const request = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?&input=hospitais&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=AIzaSyB1mOwE2IYT0nupzpA8SKNGk104ijpAhnU";
const key = "AIzaSyB1mOwE2IYT0nupzpA8SKNGk104ijpAhnU";

// https://maps.googleapis.com/maps/api/place/findplacefromtext/json?location=-22.951287,-47.3155636&input=hospitais&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=AIzaSyB1mOwE2IYT0nupzpA8SKNGk104ijpAhnU

class MapTab extends StatefulWidget {
  final Key _mapKey = UniqueKey();

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TheMap(key: widget._mapKey));
  }
}

class TheMap extends StatefulWidget {
  ///key is required, otherwise map crashes on hot reload
  TheMap({@required Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TheMap> {
  Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  LocationData currentLocation;
  LocationData destinationLocation;
  Location location;

  @override
  void initState() {
    super.initState();

    location = new Location(); //instancia a localização

    //seleciona o que fazer quando a localização mudar
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });

    setInitialLocation(); //seleciona a localização como a atual
  }

  void updatePinOnMap() async {
    // semrpe que a localização mudar, a câmera muda também
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    //Mexe a câmera para a nova posição:
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  //Seleciona a localização atual do usuário:
  void setInitialLocation() async {
    currentLocation = await location.getLocation();

    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  //Muda o mapa de normal para satélite
  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  //Pega os dados do google maps
  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  //Botão para mudar o mapa entre normal e satélite
  Widget button(Function function, IconData icon, String herotag) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.green[500],
      child: Icon(
        icon,
        size: 36.0,
      ),
      heroTag: herotag,
    );
  }

  @override
  Widget build(BuildContext context) {
    //Cria a câmera
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM, tilt: CAMERA_TILT, target: SOURCE_LOCATION);
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
      );
    }

    return FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            default:
              if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else {
                List hospitais = snapshot.data["candidates"];

                if (hospitais.isNotEmpty) {
                  for (int i = 0; i < hospitais.length; i++) {
                    String endereco = hospitais[i]["formatted_address"];
                    String nome = hospitais[i]["name"];
                    double lat = hospitais[i]["geometry"]["location"]["lat"];
                    double long = hospitais[i]["geometry"]["location"]["lng"];
                    bool open_now = hospitais[i]["opening_hours"]["open_now"];
                    List<dynamic> images = hospitais[i]["photos"];
                    double nota = hospitais[i]["rating"];

                    LatLng _position = new LatLng(lat, long);

                    var hospitaldata = new HospitalData(
                        nome,
                        endereco,
                        lat,
                        long,
                        open_now,
                        images,
                        nota);

                    _markers.add(
                      Marker(
                        markerId: MarkerId(_position.toString()),
                        position: _position,
                        infoWindow: InfoWindow(
                          title: nome,
                          snippet: endereco,
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    HospitalScreen(hospitaldata)));
                          },
                        ),
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    );
                  }
                }

                return Scaffold(
                  //also this avoids it crashing/breaking when the keyboard is up
                  resizeToAvoidBottomInset: false,
                  body: Stack(
                    children: <Widget>[
                      GoogleMap(
                        myLocationEnabled: true,
                        compassEnabled: true,
                        tiltGesturesEnabled: false,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: initialCameraPosition,
                        mapType: _currentMapType,
                        markers: _markers,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 60.0,
                              ),
                              button(_onMapTypeButtonPressed, Icons.map,
                                  "btn1"),
                              SizedBox(
                                height: 16.0,
                              ),
                              EmergencyButton()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        });
  }
}
