import 'package:flutter/material.dart';
import 'package:task1_authentication/screens/login.dart';
import 'package:task1_authentication/screens/register.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/register': (context) => Register(),
      },
    ));
