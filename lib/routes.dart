import 'package:apply_asyncredux/user_interface/home/home_page.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final home = '/';
  static final counter = '/counter';
  static final data = '/data';
  static final routes = {
    '/': (BuildContext context) => HomePage(),
    '/counter': (BuildContext context) => HomePage(),
    '/data': (BuildContext context) => HomePage(),
  };
}

class Keys {
  static final navigatorKey = GlobalKey<NavigatorState>();
}
