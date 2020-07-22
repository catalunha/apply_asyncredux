import 'package:flutter/material.dart';

class CounterPageDS extends StatelessWidget {
  final int counter;
  final String description;
  final bool waiting;

  final Function() onIncrement;

  const CounterPageDS({
    Key key,
    this.counter,
    this.onIncrement,
    this.description,
    this.waiting,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Applying AsyncRedux by '),
          ),
          body: ListTile(
            title: Text('onIncrement = $counter'),
            subtitle: Text('description: $description'),
          ),
          // body: Center(
          //   child: Text('onIncrement = $counter'),
          // ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              onIncrement();
            },
            child: Icon(Icons.add),
          ),
        ),
        if (waiting) ModalBarrier(color: Colors.red.withOpacity(0.4)),
      ],
    );
  }
}
