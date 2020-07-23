import 'package:async_redux/async_redux.dart';

class DataState {
  final String name;
  final int number;
  final bool waiting;
  final Event clearTextEvt;
  final Event<String> changeTextEvt;
  final Map<int, String> descriptions;
  DataState(
      {this.name,
      this.number,
      this.waiting,
      this.clearTextEvt,
      this.changeTextEvt,
      this.descriptions});
  factory DataState.initialState() {
    return DataState(
      name: '',
      number: 0,
      waiting: false,
      clearTextEvt: Event.spent(),
      changeTextEvt: Event<String>.spent(),
      descriptions: {},
    );
  }
  DataState copyWith({
    String name,
    int number,
    bool waiting,
    Event clearTextEvt,
    Event<String> changeTextEvt,
    Map<int, String> descriptions,
  }) {
    return DataState(
      name: name ?? this.name,
      number: number ?? this.number,
      waiting: waiting ?? this.waiting,
      clearTextEvt: clearTextEvt ?? this.clearTextEvt,
      changeTextEvt: changeTextEvt ?? this.changeTextEvt,
      descriptions: descriptions ?? this.descriptions,
    );
  }

  @override
  int get hashCode =>
      name.hashCode ^
      number.hashCode ^
      waiting.hashCode ^
      descriptions.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataState &&
          name == other.name &&
          number == other.number &&
          waiting == other.waiting &&
          descriptions == other.descriptions &&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'DataState...';
  }
}
