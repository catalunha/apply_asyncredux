import 'package:apply_asyncredux/states/counter_state.dart';
import 'package:apply_asyncredux/states/data_state.dart';

class AppState {
  final CounterState counterState;
  final DataState dataState;
  AppState({
    this.counterState,
    this.dataState,
  });
  factory AppState.initialState() {
    return AppState(
      counterState: CounterState.initialState(),
      dataState: DataState.initialState(),
    );
  }
  AppState copyWith({
    CounterState counterState,
    DataState dataState,
  }) {
    return AppState(
      counterState: counterState ?? this.counterState,
      dataState: dataState ?? this.dataState,
    );
  }

  @override
  int get hashCode => counterState.hashCode ^ dataState.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          counterState == other.counterState &&
          dataState == other.dataState &&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'AppState{CounterState:${counterState.toString()}}';
  }
}
