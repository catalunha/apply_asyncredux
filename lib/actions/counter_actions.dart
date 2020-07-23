import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:apply_asyncredux/states/app_state.dart';
import 'package:apply_asyncredux/states/counter_state.dart';
import 'package:http/http.dart';

class IncrementCounterAction extends ReduxAction<AppState> {
  final int amount;

  IncrementCounterAction({this.amount}) : assert(amount != null);

  @override
  AppState reduce() {
    CounterState _counterState = state.counterState
        .copyWith(counter: state.counterState.counter + amount);
    return state.copyWith(
      counterState: _counterState,
    );
  }
}

class IncrementAndGetDescriptionCounterAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    dispatch(IncrementCounterAction(amount: 1));
    String description =
        await read('http://numbersapi.com/${state.counterState.counter}');
    return state.copyWith(
      counterState: state.counterState.copyWith(
        descriptionNumber: description,
      ),
    );
  }

  @override
  void before() => dispatch(WaitAction.add(this));
  @override
  void after() => dispatch(WaitAction.remove(this));

  // @override
  // void before() => dispatch(BarrierCounterAction(true));
  // @override
  // void after() => dispatch(BarrierCounterAction(false));
}

class BarrierCounterAction extends ReduxAction<AppState> {
  final bool waiting;

  BarrierCounterAction(this.waiting);
  @override
  AppState reduce() {
    return state.copyWith(
      counterState: state.counterState.copyWith(
        waiting: waiting,
      ),
    );
  }
}
