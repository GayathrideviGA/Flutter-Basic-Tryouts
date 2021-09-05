import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyNotifications extends StatefulWidget {
  @override
  _MyNotificationsState createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> 
{
final FirebaseMessaging _messaging = FirebaseMessaging();
 @override
 void initState()
 {
   super.initState();
   _messaging.getToken().then((token) {
      print(token);
    });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Push Notifications')
      ),
       body: new Center(
        
        child: new Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Notifications',
            ),
            
          ],
        ),
      ),
      
    );
  }
}