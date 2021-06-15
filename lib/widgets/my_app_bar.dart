import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({context, title})
      : super(
          shadowColor: Colors.white,
          elevation: 1.5,
          centerTitle: true,
          brightness: Brightness.light,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 2),
          ),
          backgroundColor: Colors.white,
        );
}
