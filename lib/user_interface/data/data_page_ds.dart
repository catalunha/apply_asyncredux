import 'package:flutter/material.dart';

class DataPageDS extends StatefulWidget {
  final String name;
  final Function(String) onSaveName;

  const DataPageDS({Key key, this.name, this.onSaveName}) : super(key: key);
  @override
  _DataPageDSState createState() => _DataPageDSState();
}

class _DataPageDSState extends State<DataPageDS> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Error Dialog Example'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Type a name and save:\n(See error if less than 4 chars)'),
            TextField(
              controller: controller,
              onSubmitted: widget.onSaveName,
            ),
            Text('Current name: ${widget.name}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.onSaveName(controller.text),
        child: Text('Save'),
      ),
    );
  }
}
