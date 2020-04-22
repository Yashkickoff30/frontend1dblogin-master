import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Questions.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration form"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body:  SingleChildScrollView(
        child: Container(

          child: Stack(
            children: <Widget>[
              background(),
              Formdetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset('assets/background1.jpg',),
        ],
      ),
    );
  }

}

class Formdetails extends StatefulWidget {
  @override
  _FormdetailsState createState() => _FormdetailsState();
}

class _FormdetailsState extends State<Formdetails> {
  final _fs = Firestore.instance;
  FirebaseUser fbuser;
  String userName;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        fbuser = user;
        userName = fbuser.email;
      }
    } catch (e) {
      print(e);
    }
  }


  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  String name;
  String phoneNo;
  String age;
  String occupation;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                  name = val;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.black, size: 30.0),
                    hintText: 'Enter your name :',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(name){
                  Pattern pattern =
                      r'^[ A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(name))
                    return 'Invalid username';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                  phoneNo = val;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.black, size: 30.0),
                    hintText: 'Enter your phoneno:',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Phone',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(phoneNO){
                  Pattern pattern =
                      r'^[ 0-9]+(?:[ _-][0-9]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(phoneNO))
                    return 'Invalid phonenumber';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                  age = val;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.ac_unit, color: Colors.black, size: 30.0),
                    hintText: 'Enter your age:',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Age',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(age){
                  Pattern pattern =
                      r'^[ 0-9]+(?:[0-9]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(age))
                    return 'Invalid age';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                  occupation = val;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.work, color: Colors.black, size: 30.0,
                    ),
                    hintText: 'Occupation:',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Profession',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(occupation){
                  Pattern pattern =
                      r'^[ A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(occupation))
                    return 'Invalid phonenumber';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 150.0, top: 40.0),
              child: RaisedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Questions()));
                  }
                  _fs.collection('info').add({
                    'email': userName,
                    'name': name,
                    'phone': phoneNo,
                    'age': age,
                    'occupation': occupation,
                  });
                },
                child: Text(
                  'submit',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
