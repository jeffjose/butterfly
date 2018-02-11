import 'package:flutter/material.dart';
import 'package:butterfly/routes.dart';
import 'package:butterfly/ui/home/homepage.dart';

void main() {
  Routes.initRoutes();

  runApp(new MaterialApp(
    home: new HomePage(),
  ));
}
