import 'package:flutter/material.dart';
import 'package:flutter_app/loginscreen/SignIn.dart';
import 'package:flutter_app/loginscreen/SignUp.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff15191c),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              child: Container(
                  alignment: Alignment.topCenter,
                  child:
                  Image.asset("images/welcomelogo2.png")
              ),
            ),
            SizedBox(
              height: 16,),
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              //disabledColor: Colors.black,
              color: Color(0xffF9A828),
              onPressed: navigateToSignIn,
              child:
              Text('Sign In')
            ),
          ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                //disabledColor: Colors.black,
                  color: Color(0xffF9A828),
                  onPressed: navigateToSignUp,
                  child:
                  Text('Sign Up')
              ),
            ),
          ],
        )
      ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SignIn(),fullscreenDialog: true
    ));
  }
  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => SignUp()
    ));
  }
}
