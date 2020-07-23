import 'dart:async';

import 'package:apply_asyncredux/states/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart';

class SaveUserDataAction extends ReduxAction<AppState> {
  final String name;

  SaveUserDataAction(this.name);

  @override
  AppState reduce() {
    print('Saving $name');
    if (name.length < 4) {
      throw UserException('Name must have at least 4 letters');
    }
    return state.copyWith(
      dataState: state.dataState.copyWith(name: name),
    );
  }

  @override
  Object wrapError(error) => UserException(
        'Save failed',
        cause: error,
      );
}

class ClearTextDataAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      dataState: state.dataState.copyWith(
        clearTextEvt: Event(),
      ),
    );
  }
}

class ChangeTextDataAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    String newText =
        await read('http://numbersapi.com/${state.dataState.number}');
    return state.copyWith(
      dataState: state.dataState.copyWith(
        number: state.dataState.number + 1,
        changeTextEvt: Event<String>(newText),
      ),
    );
  }
}

abstract class BarrierAction extends ReduxAction<AppState> {
  @override
  void before() => dispatch(_WaitDataAction(true));
  void after() => dispatch(_WaitDataAction(false));
}

class _WaitDataAction extends ReduxAction<AppState> {
  final bool waiting;

  _WaitDataAction(this.waiting);
  @override
  AppState reduce() => state.copyWith(
        dataState: state.dataState.copyWith(
          waiting: waiting,
        ),
      );
}

class GetDescriptionDataAction extends ReduxAction<AppState> {
  int index;
  GetDescriptionDataAction(this.index);
  @override
  Future<AppState> reduce() async {
    String description = await read('http://numbersapi.com/$index');
    await Future.delayed(
      Duration(seconds: 2),
    );
    Map<int, String> newDescriptions = Map.of(state.dataState.descriptions);
    newDescriptions[index] = description;
    return state.copyWith(
      dataState: state.dataState.copyWith(
        descriptions: newDescriptions,
      ),
    );
  }

  @override
  void before() => dispatch(WaitAction.add(index));
  @override
  void after() => dispatch(WaitAction.remove(index));
}
