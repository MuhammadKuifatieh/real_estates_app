import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();
  var isLoading = false;

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var authData = {'email': '', 'password': '', 'c_password': '', 'name': ''};

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
      await Provider.of<Auth>(context, listen: false).signUp(
        email: authData['email'],
        password: authData['password'],
        name: authData['name'],
      );
    } on HttpException catch (error) {
      _showAuthDialog(error.message);
    } catch (e) {
      _showAuthDialog('please check you internet connection.');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    focusNodePassword.dispose();
    signupPasswordController.dispose();
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
                  overflow: Overflow.visible,
                  alignment: Alignment.topCenter,
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
                                  focusNode: focusNodeName,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.account_circle_rounded,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0),
                                  ),
                                  onFieldSubmitted: (_) {
                                    focusNodeEmail.requestFocus();
                                  },
                                  validator: (value) {
                                    if (value.length < 5) {
                                      return 'The name should contain at least 5 charachters';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    authData['name'] = value;
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
                                  focusNode: focusNodeEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0),
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
                                  controller: signupPasswordController,
                                  obscureText: _obscureTextPassword,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: const Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleSignup,
                                      child: Icon(
                                        _obscureTextPassword
                                            ? Icons.remove_red_eye_sharp
                                            : CupertinoIcons.eye_slash,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  onFieldSubmitted: (_) {
                                    focusNodeConfirmPassword.requestFocus();
                                  },
                                  validator: (value) {
                                    if (value.length < 8)
                                      return "The password should contain at least 8 charachters";
                                    return null;
                                  },
                                  onSaved: (value) {
                                    authData['password'] = value;
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
                                  focusNode: focusNodeConfirmPassword,
                                  obscureText: _obscureTextConfirmPassword,
                                  autocorrect: false,
                                  style: const TextStyle(
                                      fontFamily: 'WorkSansSemiBold',
                                      fontSize: 16.0,
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: const Icon(
                                      Icons.lock_clock,
                                      color: Colors.black,
                                    ),
                                    hintText: 'Confirmation',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0),
                                    suffixIcon: GestureDetector(
                                      onTap: _toggleSignupConfirm,
                                      child: Icon(
                                        _obscureTextConfirmPassword
                                            ? Icons.remove_red_eye_sharp
                                            : Icons.remove_red_eye_outlined,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.go,
                                  validator: (value) {
                                    if (value !=
                                        signupPasswordController.text) {
                                      return 'This password does not match the password above';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    authData['c_password'] = value;
                                  },
                                  onFieldSubmitted: (_) {
                                    _saveForm();
                                  },
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
                        // margin: const EdgeInsets.only(top: 340.0),
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
                            splashColor: Colors.blue,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: 'WorkSansBold'),
                              ),
                            ),
                            onPressed: () => _saveForm()),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
