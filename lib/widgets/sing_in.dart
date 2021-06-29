import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var authData = {'email': '', 'password': ''};

  void _showAuthDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('An Error Occured!'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            )
          ],
        );
      },
    );
  }

  void _saveForm() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).logIn(
        email: authData['email'],
        password: authData['password'],
      );
    } on HttpException catch (error) {
      _showAuthDialog(error.message);
    }
    setState(() {
      isLoading = false;
    });
  }

  bool _obscureTextPassword = true;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        : Container(
            padding: const EdgeInsets.only(top: 23.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 300.0,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextFormField(
                                  focusNode: focusNodeEmail,
                                  controller: loginEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 17.0),
                                  ),
                                  onFieldSubmitted: (_) {
                                    focusNodePassword.requestFocus();
                                  },
                                  validator: (value) {
                                    if (!value.contains('@'))
                                      return "Please provide a valid email";
                                    return null;
                                  },
                                  onSaved: (value) {
                                    authData['email'] = value;
                                  },
                                ),
                              ),
                              Container(
                                width: 250.0,
                                height: 1.0,
                                color: Colors.grey[400],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 25.0,
                                    right: 25.0),
                                child: TextFormField(
                                  focusNode: focusNodePassword,
                                  controller: loginPasswordController,
                                  obscureText: _obscureTextPassword,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: const Icon(
                                      Icons.lock,
                                      size: 22.0,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 17.0),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleLogin,
                                      child: Icon(
                                        _obscureTextPassword
                                            ? Icons.remove_red_eye
                                            : Icons.remove_red_eye_outlined,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.go,
                                  validator: (value) {
                                    if (value.length < 8)
                                      return "The password should at least contain 8 charachters";
                                    return null;
                                  },
                                  onSaved: (value) {
                                    authData['password'] = value;
                                  },
                                  onFieldSubmitted: (_) => _saveForm(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -25,
                      child: Container(
                        // margin: const EdgeInsets.only(top: 170.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.blue,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Colors.blueAccent,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: LinearGradient(
                              colors: <Color>[
                                Colors.lightBlue,
                                Colors.blueGrey,
                              ],
                              begin: FractionalOffset(0.2, 0.2),
                              end: FractionalOffset(1.0, 1.0),
                              stops: <double>[0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.blueAccent,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: 'WorkSansBold'),
                            ),
                          ),
                          onPressed: () => _saveForm(),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'WorkSansMedium'),
                      )),
                ),
              ],
            ),
          );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
