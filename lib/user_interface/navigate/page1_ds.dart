import 'package:flutter/material.dart';

class Page1DS extends StatelessWidget {
  final Function() onChangePage;

  const Page1DS({Key key, this.onChangePage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page with NavigateAcion'),
      ),
      body: RaisedButton(
        onPressed: onChangePage,
        child: Text('click to back'),
      ),
    );
  }
}
