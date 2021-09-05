import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers;
  static BitmapDescriptor customIcon;
  Future getCustomicon() async
  
  {
    BitmapDescriptor custom = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(200, 100)), 'assets/icon.png');
    setState(() {
      customIcon = custom;
    });
  }
  void initState()
  {
    getCustomicon();
    super.initState();
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[900], title: Text('Map')),
      body: 
    
      Stack(children: <Widget>[

       _showGooglemap(context),
      ]),
    );
  }

  Widget _showGooglemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(12.913247, 77.602511), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          microlayout,
          kiruvanapark,
          bhagathsinghpark,
          kuvembu,
          nandhini
        },
      ),
    );
  }

  Marker microlayout = Marker(
    markerId: MarkerId('Micro Layout park'),
    position: LatLng(12.911780, 77.604770),
    infoWindow: InfoWindow(title: 'Micro Layout park'),
    icon: customIcon,
  );
  Marker kiruvanapark = Marker(
    markerId: MarkerId('Kiruvana park'),
    position: LatLng(12.911513, 77.601882),
    infoWindow: InfoWindow(title: 'Kiruvana park'),
   icon: customIcon,
  );
  Marker bhagathsinghpark = Marker(
    markerId: MarkerId('Bhagathsingh park'),
    position: LatLng(12.911994, 77.598749),
    infoWindow: InfoWindow(title: 'Bhagathsingh park'),
    icon: customIcon,
  );
  Marker kuvembu = Marker(
    markerId: MarkerId('Kuvembu park'),
    position: LatLng(12.981058, 77.654257),
    infoWindow: InfoWindow(title: 'Kuvembu park'),
    icon: customIcon,
    // icon: BitmapDescriptor.defaultMarkerWithHue( BitmapDescriptor.hueRed, ),
  );
  Marker nandhini = Marker(
    markerId: MarkerId('Nadhini park'),
    position: LatLng(12.911513, 77.601839),
    infoWindow: InfoWindow(title: 'Nadhini park'),
      icon: customIcon,
    //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed,),
  );
}
