class CounterState {
  final int counter;
  final String descriptionNumber;
  final bool waiting;
  CounterState({
    this.counter,
    this.descriptionNumber,
    this.waiting,
  });

  factory CounterState.initialState() {
    return CounterState(counter: 0, descriptionNumber: '', waiting: false);
  }
  CounterState clone({int counter, String descriptionNumber, bool waiting}) {
    return CounterState(
      counter: counter ?? this.counter,
      descriptionNumber: descriptionNumber ?? this.descriptionNumber,
      waiting: waiting ?? this.waiting,
    );
  }

  @override
  int get hashCode =>
      counter.hashCode ^ descriptionNumber.hashCode ^ waiting.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounterState &&
          counter == other.counter &&
          descriptionNumber == other.descriptionNumber &&
          waiting == other.waiting &&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'CounterState{counter:$counter,descriptionNumber:$descriptionNumber,waiting:$waiting}';
  }
}
