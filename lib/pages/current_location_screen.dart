import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(1.290270, 103.851959), zoom: 14.0);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        myLocationEnabled: true,
      ),
      floatingActionButton:
          SpeedDial(icon: Icons.star, backgroundColor: Colors.blue, children: [
        SpeedDialChild(
          child: const Icon(Icons.info, color: Colors.white),
          label: 'Quick Guide',
          backgroundColor: Colors.blueAccent,
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Quick Guide"),
                content: const Text(
                    "Current Location - Shows your position on the map\n\nRecommended - Shows the recommended shops for you based on your past activity\n\nSearch - Search for a shop through its name\n\nSaved - Shows the shops you have favourited in the past"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(14),
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.recommend, color: Colors.white),
          label: 'Recommended',
          backgroundColor: Colors.blueAccent,
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Recommended"),
                content: const Text("- New2U Thrift Shop\n\n- Nonmainstream"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(14),
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SpeedDialChild(
          label: 'Current Location',
          backgroundColor: Colors.blueAccent,
          child: FloatingActionButton.extended(
            
            onPressed: () async {
              Position position = await _determinePosition();

              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 14)));

              markers.clear();

              BitmapDescriptor markerbitmap1 =
                  await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(size: Size(30.0, 30.0)),
                "assets/human.png",
              );

              markers.add(
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: LatLng(position.latitude, position.longitude),
                  infoWindow: const InfoWindow(
                      title: 'My Current Location',
                      snippet: 'Psst... it is a secret'),
                  icon: markerbitmap1,
                  draggable: true,
                ),
              );

              final thriftShops = [
                const Marker(
                    markerId: MarkerId('Swapaholic'),
                    position: LatLng(1.30114, 103.8395),
                    infoWindow: InfoWindow(
                        title: 'Swapaholic',
                        snippet:
                            '#02 The Centrepoint, 04A, Singapore 238843 <p> Ratings: 4.8/5 <p> Opening Hours: Mon - Sun: 12am-9pm')),
                const Marker(
                    markerId: MarkerId('TheFashionPulpit'),
                    position: LatLng(1.27724, 103.84877),
                    infoWindow: InfoWindow(
                        title: 'The Fashion Pulpit',
                        snippet:
                            '6A Shenton Way, Oue Downtown Gallery, #02-08 The Fashion Pulpit, Singapore 068815 <p> Ratings: 4.9/5 <p> Opening Hours: Tues - Sun: 11am-7pm <p> Closed on Monday.')),
                const Marker(
                    markerId: MarkerId('SsvpShop'),
                    position: LatLng(1.278140, 103.849130),
                    infoWindow: InfoWindow(
                        title: 'SSVP Shop',
                        snippet:
                            '501 Geylang Rd, Singapore 389459 <p> Ratings: 4.7/5 <p> Opening Hours: Tues - Sun: 10am-4pm <p> Closed on Monday.')),
                const Marker(
                    markerId: MarkerId('Nonmainstream'),
                    position: LatLng(1.304890, 103.860770),
                    infoWindow: InfoWindow(
                        title: 'Nonmainstream',
                        snippet:
                            '462A Crawford Ln, #02-73, Singapore 191462 <p> Ratings: 4.5/5 <p> Opening Hours: Fri - Sun: 1-7pm <p> Closed from Monday to Thursday.')),
                const Marker(
                    markerId: MarkerId('LoopGarms'),
                    position: LatLng(1.306690, 103.855160),
                    infoWindow: InfoWindow(
                        title: 'Loop Garms',
                        snippet:
                            '635 Veerasamy Rd, #01-148, Singapore 200635 <p> Ratings: 4.6/5 <p> Opening Hours: Fri - Sun: 12-7.30pm <p> Closed from Monday to Thursday.')),
                const Marker(
                    markerId: MarkerId('RetroGate'),
                    position: LatLng(1.30315, 103.86503),
                    infoWindow: InfoWindow(
                        title: 'Retro Gate',
                        snippet:
                            '5001 Beach Rd, #04-16 Golden Mile Complex, Singapore 199588 <p> Permanatly closed.')),
                const Marker(
                    markerId: MarkerId('Refash'),
                    position: LatLng(1.30038, 103.8452),
                    infoWindow: InfoWindow(
                        title: 'Refash',
                        snippet:
                            '68 Orchard Rd, #03-41, Singapore 238839 <p> Ratings: 2.5/5 <p> Opening Hours: Mon - Sun: 11.30am-9.30pm')),
                const Marker(
                    markerId: MarkerId('DejaVuVintage'),
                    position: LatLng(1.29139, 103.859497),
                    infoWindow: InfoWindow(
                        title: 'Deja Vu Vintage',
                        snippet:
                            '9 Raffles Blvd, #01-70, Millenia Walk, Singapore 039596 <p> Ratings: 3.9/5 <p> Opening Hours: Mon - Thurs: 12-8pm <p> Fri - Sun: 11am-9pm')),
                const Marker(
                  markerId: MarkerId('New2uThriftShop'),
                  position: LatLng(1.29925, 103.85195),
                  infoWindow: InfoWindow(
                      title: 'New2U Thrift Shop',
                      snippet:
                          '96 Waterloo St, Singapore 187967 <p> Ratings: 3.8/5 <p> Opening hours: Mon - Fri: 10.30am-2.30pm <p> Closed on weekends.'),
                ),
                const Marker(
                  markerId: MarkerId('FunctionFiveThriftShop'),
                  position: LatLng(1.30072, 103.85956),
                  infoWindow: InfoWindow(
                      title: 'Function Five Thrift Shop',
                      snippet:
                          '43 Arab St, Singapore 199742 <p> Ratings: 4.9/5 <p> Opening Hours: Mon - Sun: 1-9pm'),
                ),
                const Marker(
                    markerId: MarkerId('StyleTribute'),
                    position: LatLng(1.27545, 103.79461),
                    infoWindow: InfoWindow(
                        title: 'StyleTribute',
                        snippet:
                            '102F Pasir Panjang Rd, #04-07 Citilink Warehouse Complex, Singapore 118530 <p> Ratings: 4.1/5 <p> Opening Hours: Mon - Fri: 9am-6pm <p> Closed on weekends.')),
                const Marker(
                    markerId: MarkerId('NightingaleThriftShop'),
                    position: LatLng(1.287540, 103.803420),
                    infoWindow: InfoWindow(
                        title: 'Nightingale Thrift Shop',
                        snippet:
                            '1 Queensway Queensway Shopping Centre, #03-05, Singapore 149053 <p> Ratings: 4.8/5 <p> Opening Hours: Wednesday & Friday: 2-6.30pm <p> Sat - Sun: 2-7pm <p> Closed on Monday, Tuesday and Thursday.')),
              ];
              markers.addAll(thriftShops);

              setState(() {});
            },
            label: const Icon(Icons.location_history),
          ),
        )
      ]),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
