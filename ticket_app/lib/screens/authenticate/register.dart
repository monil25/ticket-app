import 'package:ticket_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app/shared/constants.dart';
import 'package:ticket_app/shared/loading.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String mobileNumber = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign up to M-Ticket'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //Name,Mobile number,email,password
                      //name
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Name'),
                        validator: (val) {
                          if (val.length < 3)
                            return 'Name must be more than 2 charater';
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      //mobileNumber
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Mobile Number'),
                        validator: (val) {
                          String patttern = r'([0-9]{10})';
                          RegExp regExp = new RegExp(patttern);
                          if (val.length == 0) {
                            return 'Please enter mobile number';
                          } else if (!regExp.hasMatch(val)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => mobileNumber = val);
                        },
                      ),
                      //email
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please fill the email';
                          }
                          if (EmailValidator.validate(val) == false) {
                            return 'Email invalid';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      //password
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      //confirmPassword
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'confirm password'),
                        obscureText: true,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please fill confirm password';
                          }
                          if (val.compareTo(password) != 0) {
                            return "Password does not match with above password";
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, name, mobileNumber);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Some Error Ocurred while Registeration';
                                });
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
