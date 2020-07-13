import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/loginscreen/SignIn.dart';
import 'package:flutter_app/widgit/widgit.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                onPressed: SignUp,
                child:
                Text('Sign Up'),
              ),
              SizedBox(
                height: 16,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignIn()));},
                      child: Text(
                        'Already Have an Account? SignIn',
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



  Widget ShowAlert() {
    if (_error != null) {
      return Container(
        color: Color(0xffECECEB),
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_error, maxLines: 3)),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _error = null;
                });
              },
            )
          ],
        ),
      );
    }
  }

      Future<void> SignUp()async {
    if(_globalKey.currentState.validate()){
      _globalKey.currentState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => SignIn()
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
