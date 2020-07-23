import 'dart:async';
import 'dart:convert';

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

class LoadMoreDataAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    Response response = await get(
        'http://numbersapi.com/${state.dataState.numTrivias.length}..${state.dataState.numTrivias.length + 19}');
    List<String> list = state.dataState.numTrivias;
    Map<String, dynamic> map = jsonDecode(response.body);
    map.forEach((String key, value) => list.add(value.toString()));
    return state.copyWith(
      dataState: state.dataState.copyWith(
        numTrivias: list,
      ),
    );
  }

  @override
  void before() => dispatch(IsLoadingDataAction(true));
  @override
  void after() => dispatch(IsLoadingDataAction(false));
}

class RefreshDataAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    Response response = await get('http://numbersapi.com/0..19');
    List<String> list = [];
    Map<String, dynamic> map = jsonDecode(response.body);
    map.forEach((String key, value) => list.add(value.toString()));
    return state.copyWith(
      dataState: state.dataState.copyWith(
        numTrivias: list,
      ),
    );
  }

  @override
  void before() => dispatch(IsLoadingDataAction(true));
  @override
  void after() => dispatch(IsLoadingDataAction(false));
}

class IsLoadingDataAction extends ReduxAction<AppState> {
  final bool value;
  IsLoadingDataAction(this.value);
  @override
  AppState reduce() => state.copyWith(
        dataState: state.dataState.copyWith(
          isLoading: value,
        ),
      );
}
