import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:apply_asyncredux/routes.dart';
import 'package:apply_asyncredux/states/app_state.dart';

Store<AppState> store = Store<AppState>(
  initialState: AppState.initialState(),
  actionObservers: [Log<AppState>.printer()],
  modelObserver: DefaultModelObserver(),
);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NavigateAction.setNavigatorKey(Keys.navigatorKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'ApplyAsyncRedux',
        routes: Routes.routes,
        navigatorKey: Keys.navigatorKey,
        // home: UserExceptionDialog<AppState>(
        //   child: HomePage(),
        // ),
      ),
    );
  }
}
