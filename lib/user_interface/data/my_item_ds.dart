import 'package:flutter/material.dart';

class MyItemDS extends StatelessWidget {
  final int index;
  final void Function(int) onGetDescription;
  final String description;
  final bool waiting;

  const MyItemDS({
    Key key,
    this.index,
    this.onGetDescription,
    this.description,
    this.waiting,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget contents;
    if (waiting) {
      contents = _progressIndicator();
    } else if (description != null) {
      contents = _indexDescription();
    } else {
      contents = _button();
    }

    return Container(
      height: 70,
      child: Center(
        child: contents,
      ),
    );
  }

  MaterialButton _button() => MaterialButton(
        color: Colors.blue,
        child: Text('Click $index'),
        onPressed: () => onGetDescription(index),
      );
  Text _indexDescription() => Text(
        description,
      );
  CircularProgressIndicator _progressIndicator() => CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      );
}
