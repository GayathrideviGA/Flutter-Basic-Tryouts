import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1_authentication/screens/Homescreen.dart';
import 'package:task1_authentication/screens/register.dart';
import 'package:task1_authentication/utils/colors.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}



class LoginState extends State<Login> 
{
  final formkey = new GlobalKey<FormState>();
  String email;
  String password;

  bool validateForm() 
  { 
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndsubmit() async {
    if (validateForm()) {
      try {
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)) .user;
        print('Signed in: ${user.uid}');
      } catch (e) 
      {
        
       showDialog(context: context,
        builder: (BuildContext context)
        {
          return AlertDialog
          (
           content: Text('Your email id is not registered.Create one'),
           actions: <Widget>
           [
             FlatButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.blue),
          ))
           ],
          );
        }
        );
        
        print('Error:$e');
      }
    } else {
      print('Something went wrong');
    }
     setState(() 
     {
      formkey.currentState.reset();
    });
  }

 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: Applicationcolor.loginbackground,
        ),
        child: SizedBox.expand(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://worldwaterskiers.com/wp-content/themes/WorldWaterSkiers/downloads/logos/W-Icon-White-Blue-Circle-Outline.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.only(bottom:20),
                  width: width / 1.1,
                  height: height / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 2)],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: formInputes() + submitButton(),
                    ),
                  )),
                 /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom:20),child: Text('Sign up with'),),
                    
                    ],
                  ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children:<Widget>
               [
                 IconButton(
                   onPressed:(){},
                   icon:FaIcon(FontAwesomeIcons.google,size: 50,color: Colors.white),
                 ),
                 IconButton(
                   onPressed:(){},
                   icon:FaIcon(FontAwesomeIcons.facebook,size: 50,color:Colors.white),
                  
                 )
               ]
             )*/
            ]
            
            )
            ),

      ),

    ));
  }

  List<Widget> formInputes() 
  {
    return [
      Padding(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: 'Enter your email address',
              icon: Icon(Icons.person, color: Colors.blueGrey)),

          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => email = value,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Enter your passowrd',
              icon: Icon(Icons.lock, color: Colors.blueGrey)),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => password = value,
        ),
      )
    ];
  }

  List<Widget> submitButton() 
  {
    return [
      RaisedButton(
          color: Colors.blue,
          onPressed: () {
            validateAndsubmit();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
          },
          child: Text(
            'Sign in',
            style: TextStyle(color: Colors.white),
          )),
      FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            'Don\'t have an account ? Sign Up',
            style: TextStyle(color: Colors.blue),
          )),
    ];
  }
}
