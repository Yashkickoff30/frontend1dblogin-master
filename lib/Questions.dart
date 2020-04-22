//import 'package:covid/Dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Questions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        title: Text("Self Assessment"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),

      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            background(),
            Formdetails(),
          ],
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
  bool checkvalue=false;

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

  List<String> question = ['Qn1', 'Qn2', 'Qn3', 'Qn4', 'Qn5'];
  String ans1, ans2, ans3, ans4;
  String qn1 = 'Travelled out in past 30days?';
  String qn2 = 'Willing to volunteer when needed?';
  String qn3 = 'Do you have any health issues?';
  String qn4 =
      'Did you come interact or in contact with someone who has tested positive for COVID-19?';

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
                ans1 = val;
                },
                decoration: const InputDecoration(
                    hintText: 'Travel History',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Travelled out in past 30days?',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(ans1){
                  Pattern pattern =
                      r'^[ A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(ans1))
                    return 'Invalid answer';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                ans2 = val;
                },
                decoration: const InputDecoration(
                    hintText: 'yes/no:',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Willing to help needy when needed?',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(ans2){
                  if (ans2!="yes" && ans2!="no")
                    return 'Invalid answer TYPE:yes/no';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                ans3 = val;
                },
                decoration: const InputDecoration(
                    hintText: 'Personal Health:',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'How is your health?',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(ans3){
                  Pattern pattern =
                      r'^[ A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(ans3))
                    return 'Invalid answer';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                ans4 = val;
                },
                decoration: const InputDecoration(
                    hintText: 'in celcius',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Enter your body temperature:',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(ans4){
                  Pattern pattern =
                      r'^[ 0-9]+(?:[0-9]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(ans4))
                    return 'Invalid temperature';
                  else
                    return null;

                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (val) {
                ans4 = val;
                },
                decoration: const InputDecoration(
                    hintText: 'yes/no:',
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: 'Willing to take 20 seconds selftesting??',
                    labelStyle: TextStyle(color: Colors.white)),
                validator:(ans2){
                  if (ans2!="yes" && ans2!="no")
                    return 'Invalid answer TYPE:yes/no';
                  else
                    return null;

                },
              ),
            ),

            Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Checkbox(value: checkvalue, onChanged:(bool value){
                      setState(() {
                        checkvalue=value;
                      });
                    }),
                    Text("I here by CONFIRM the above\n"
                        "information is true.",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight:FontWeight.bold),overflow: TextOverflow.ellipsis,),
                  ],
                )
            ),

            Container(
              padding: EdgeInsets.only(left: 140.0, top: 80.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (checkvalue == true) {
                      Scaffold.of(context)
                          .showSnackBar(
                          SnackBar(content: Text('Data is in processing.')));
                    }
                    else {
                      Scaffold.of(context)
                          .showSnackBar(
                          SnackBar(content: Text('CONFIRM your action.')));
                    }
                    //Navigator.push(context,
                   // MaterialPageRoute(builder: (context) => Dashboard()));
                  }

                  _fs.collection('info').add({
                    'email': userName,
                    qn1: ans1,
                    qn2: ans2,
                    qn3: ans3,
                    qn4: ans4
                  });

                },
                child: Text(
                  'proceed',
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


