import 'dart:async';

import 'package:apply_asyncredux/states/app_state.dart';
import 'package:async_redux/async_redux.dart';

class SaveUserDataAction extends ReduxAction<AppState> {
  final String name;

  SaveUserDataAction(this.name);

  @override
  AppState reduce() {
    print('Saving $name');
    if (name.length < 4) {
      throw UserException('Name must have at least 4 letters');
    }
    return state.clone(
      dataState: state.dataState.clone(name: name),
    );
  }

  @override
  Object wrapError(error) => UserException(
        'Save failed',
        cause: error,
      );
}
