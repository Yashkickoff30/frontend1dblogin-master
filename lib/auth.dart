import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //signup
  Future signinwithemailandpassword(String name,String pass) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: name, password: pass);

      return result;
    }
    catch(e){
      print(e);
      return null;
    }
  }

}