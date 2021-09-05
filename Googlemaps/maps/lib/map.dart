import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapsite extends StatefulWidget
{
  @override
  Mapstate createState() => Mapstate();
}
class Mapstate extends State<Mapsite>
{
  Completer<GoogleMapController> _controller = Completer();
  static BitmapDescriptor customIcon;
  Set<Marker> markers;
  @override
  void initState() 
  {
    super.initState();
    markers = Set.from([]);
  }

  createMarker(context) 
  {
    if (customIcon == null) 
    {
      //ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon.png')
          .then((icon) 
          {
        setState(() 
        {
          customIcon = icon;
        });
      });
    }
  }

    
  double zoomVal=5.0;
  Widget build(BuildContext context)
  {
    return Scaffold
    (
    appBar: AppBar(
      backgroundColor: Colors.blue[900],
      title:Text('Map')
    ),
    body: Stack(
      children:<Widget>
      [
        _showGooglemap(context),
        _zoomminusfunction(),
        _zoomplusfunction(),
       // _buildContainer() 
      ]
    ),
    );
  }
   Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchMinus,color:Colors.blue[900]),
            onPressed: () {
              zoomVal--;
             _minus( zoomVal);
            }),
    );
 }
 Widget _zoomplusfunction() {
   
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchPlus,color:Colors.blue[900]),
            onPressed: () {
              zoomVal++;
              _plus(zoomVal);
            }),
    );
 }

 Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }
  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPjlbQ0QsNN_yNccvBKD1Rrw1IfDhk4Z8sHOA8=w408-h306-k-no",
                  12.911780, 77.604770,"Micro Layout"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMMIwdeBSII18jCxrrFuY2fhZS8tZbk-LsnXB4d=w408-h544-k-no",
                  12.911513, 77.601882,"Kiruvana park"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMmktIOeRjzIwGOXiFPejY72TX6CLrfKmWmT46M=w408-h544-k-no",
                  12.911994, 77.598749,"Bhagathsingh Park"),
            ),
             SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMu5RA3OiadHdo6zkSWmHjCkdzDn3mDerE9yfsO=w408-h306-k-no",
                  12.981058, 77.654257,"Kuvembu Park"),
            ),
             SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipNHsRDCeuC18iE8xr67tkbV2UTc6UcdwtWm5jov=w408-h544-k-no",
                  12.911513, 77.601839,"Nandhini Park"),
            ),
          ],
        ),
      ),
    );
  }
  Widget _boxes(String _image, double lat,double long,String parkName) {
    return  GestureDetector(
        onTap: () {
          _gotoLocation(lat,long);
        },
        child:Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 180,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(_image),
                            ),
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDetailsContainer1(parkName),
                          ),
                        ),

                      ],)
                ),
              ),
            ),
    );
  }
   Widget myDetailsContainer1(String parkName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(parkName,
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
        Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  child: Text(
                "4.1",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
              Container(
                child: Icon(
                  FontAwesomeIcons.solidStarHalf,
                  color: Colors.amber,
                  size: 15.0,
                ),
              ),
               Container(
                  child: Text(
                "(946)",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
            ],
          )),
          SizedBox(height:5.0),
        Container(
                  child: Text(
                "Indian 1.6 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              SizedBox(height:5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }
  Widget _showGooglemap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(12.913247, 77.602511), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
         
        markers: 
        {
          microlayout,kiruvanapark,bhagathsinghpark,kuvembu,nandhini
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async 
  {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
    //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
       //controller.setMapStyle('[{"stylers" : [{ "color": "#C0C0C0" }]}]');
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