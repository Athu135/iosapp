import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/loginscreen/SignUp.dart';
import 'dart:async';

import 'package:flutter_app/views/home.dart';
import 'package:flutter_app/widgit/widgit.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String _email, _password , _error;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff15191c),
      appBar: AppBar(
        title: Applogo() ,//brandName() ,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Form(
          key: _globalKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                          SizedBox(height:0.025),
                          ShowAlert(),
                  ],
                ),
              ),
              SizedBox(
                height: 16,),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xffF9A828),
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if(input.isEmpty){
                      return 'PLease enter your email';
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                      border:InputBorder.none,
                    labelText:'Email'
                  ),
                ),
              ),
              SizedBox(
                height: 16,),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF9A828),
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  // ignore: missing_return
                  validator: (input) {
                    if(input.isEmpty){
                      return 'password is incorrect';
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                      border:InputBorder.none,
                      labelText:'Password'
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 16,),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                //disabledColor: Colors.black,
                color: Color(0xffF9A828),
                onPressed: SignIn,
                child:
                Text('Sign In'),
              ),
              SizedBox(
                height: 16,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                       onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => SignUp()));},
                      child: Text(
                        'Create a New Account',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget ShowAlert(){
    if(_error != null ){
      return Container(
        color: Color(0xffECECEB),
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_error, maxLines: 3)),
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: (){
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0,);
  }

  Future<void> SignIn()async {
    final formState = _globalKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Home()
        ));
      }catch(e){
        setState(() {
          print(e.message);
          _error = e.message;
        });
      }
    }
  }
}
