import 'package:apply_asyncredux/states/app_state.dart';
import 'package:apply_asyncredux/user_interface/home/home_page.dart';
import 'package:apply_asyncredux/view_model/counter/counter_page.dart';
import 'package:apply_asyncredux/view_model/data/data_page.dart';
import 'package:apply_asyncredux/view_model/navigate/page1.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static final home = '/';
  static final counter = '/counter';
  static final data = '/data';
  static final routes = {
    '/': (BuildContext context) => UserExceptionDialog<AppState>(
          child: HomePage(),
        ),
    '/counter': (BuildContext context) => CounterPage(),
    '/data': (BuildContext context) => DataPage(),
    '/page1': (BuildContext context) => Page1(),
  };
}

class Keys {
  static final navigatorKey = GlobalKey<NavigatorState>();
}
