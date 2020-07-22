import 'package:apply_asyncredux/view_model/counter/counter_page.dart';
import 'package:apply_asyncredux/view_model/data/data_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Counter'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CounterPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Show Error Dialog'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DataPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
