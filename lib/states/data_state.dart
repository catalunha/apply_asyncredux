class DataState {
  final String name;

  DataState({this.name});
  factory DataState.initialState() {
    return DataState(name: '');
  }
  DataState clone({String name}) {
    return DataState(
      name: name ?? this.name,
    );
  }

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataState &&
          name == other.name &&
          runtimeType == other.runtimeType;
  @override
  String toString() {
    return 'DataState...';
  }
}
