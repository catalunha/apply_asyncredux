import 'package:apply_asyncredux/states/counter_state.dart';
import 'package:apply_asyncredux/states/data_state.dart';
import 'package:async_redux/async_redux.dart';

class AppState {
  final CounterState counterState;
  final DataState dataState;
  Wait wait;
  AppState({
    this.counterState,
    this.dataState,
    this.wait,
  });
  factory AppState.initialState() {
    return AppState(
      counterState: CounterState.initialState(),
      dataState: DataState.initialState(),
      wait: Wait(),
    );
  }
  AppState copyWith({
    CounterState counterState,
    DataState dataState,
    Wait wait,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      dataState: dataState ?? this.dataState,
      wait: wait ?? this.wait,
    );
  }

  @override
  int get hashCode =>
      counterState.hashCode ^ dataState.hashCode ^ wait.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          counterState == other.counterState &&
          dataState == other.dataState &&
          wait == other.wait &&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'AppState{CounterState:${counterState.toString()}}';
  }
}
