import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() 
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Firebase realtime database',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase realtime database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  final fb = FirebaseDatabase.instance;
  final myController = TextEditingController();
  final status = "LED STATUS";
   var retrievedName; 
 /*  @override
  void dispose() {
    //can be used when needed
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }*/
  void initState()
  {
      fb.reference().child('Esp8266_Device').child('LED_STATUS').once().then((DataSnapshot data){
                  print(data.value);
                  print(data.key);
                  setState(() {
                    retrievedName = data.value.toString();
                  });
                });
                super.initState();
  }
 
  @override
  Widget build(BuildContext context) 
  { 
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(widget.title),
      ),
    body:SizedBox.expand(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                   margin: EdgeInsets.all(20),
                   width: 200,
                   height: 200,
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.circular(100),
                     color:Colors.blue[900],
                   ),
                   child: Center(
                     child:Text(retrievedName ?? 'Status',style:TextStyle(color: Colors.white,fontSize:40))
                   ),
              ),
            /*  FlatButton(
                color: Colors.blue[900],
              onPressed: () {
              
              },
              child: Text("Get Status",style:TextStyle(color: Colors.white,fontSize:16)),
            ),*/
            
           ]
        )
    )
    );
  }
}
