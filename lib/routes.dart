import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Router _router = new Router();


  static void initRoutes() {
  }

  static void navigateTo(context, String route, {TransitionType transition}) {

    _router.navigateTo(context, route, transition: transition);
  }
}
