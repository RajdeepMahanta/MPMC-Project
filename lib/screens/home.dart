import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;
  LatLng? _currentPosition;
  Set<Marker> _markers = Set<Marker>();

  // Sample parking spots around the user
  List<LatLng> parkingSpots = [
    LatLng(37.4220, -122.0841), // Random parking spot 1
    LatLng(37.4230, -122.0821), // Random parking spot 2
    LatLng(37.4219, -122.0832), // Random parking spot 3
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Get user's current location
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return; // Location services are not enabled
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permission denied
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _setMarkers(); // Set markers for parking spots after getting the location
    });
  }

  // Set markers for parking spots
  void _setMarkers() {
    setState(() {
      // Add markers for parking spots
      for (var spot in parkingSpots) {
        _markers.add(Marker(
          markerId: MarkerId(spot.toString()),
          position: spot,
          infoWindow: InfoWindow(title: "Parking Spot"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
      }

      // Add marker for current location
      if (_currentPosition != null) {
        _markers.add(Marker(
          markerId: MarkerId("currentLocation"),
          position: _currentPosition!,
          infoWindow: InfoWindow(title: "Your Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parking Spots Near You',
          style: TextStyle(color: Colors.white), // Make the title white
        ),
        backgroundColor: Colors.green, // Make the AppBar green
        iconTheme: IconThemeData(
          color: Colors.white, // Make the icon white
        ),
        leading: IconButton(
          icon: Icon(Icons.person), // Profile icon
          onPressed: () {
            // Navigate to the profile page
            Navigator.pushNamed(context, '/profile');
          },
        ),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator()) // Show loading if location not yet available
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition!, // Start map at user's location
          zoom: 13, // Set zoom level to 13
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: _markers, // Add parking spot markers to the map
        myLocationEnabled: true, // Enable 'current location' button
      ),
    );
  }
}
