//import 'package:covid/login.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'Signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'TRACK-O-METER',
              style: TextStyle(fontSize: 20.0),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue[900],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background1.jpg'),
                  fit: BoxFit.cover),
            ),
            child: button(),
          ),
        ),
      ),
    );
  }
}

class button extends StatefulWidget {
  @override
  _buttonState createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'WELCOME,User\n',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[100],
            ),
          ),
          Text('New user?', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),
          Text("create an account:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

          SizedBox(height: 10.0),
          RaisedButton(
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Signup()));
            },
          ),
          SizedBox(height: 30.0),
          Text('Existing User?', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),
          Text("login:",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.blue[100],),),

          SizedBox(height: 10.0),
          RaisedButton(
            child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
    );
  }
}
