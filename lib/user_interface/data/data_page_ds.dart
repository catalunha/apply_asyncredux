import 'package:apply_asyncredux/view_model/data/my_item.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class DataPageDS extends StatefulWidget {
  final String name;
  final Function(String) onSaveName;
  final Function onChangePage;
  final bool waiting;
  final Event clearTextEvt;
  final Event<String> changeTextEvt;
  final Function onClearText;
  final Function onChangeText;
  final bool waiting2;
  final void Function(int) onGetDescription;
  const DataPageDS({
    Key key,
    this.name,
    this.onSaveName,
    this.onChangePage,
    this.waiting,
    this.clearTextEvt,
    this.changeTextEvt,
    this.onClearText,
    this.onChangeText,
    this.waiting2,
    this.onGetDescription,
  }) : super(key: key);
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
  void didUpdateWidget(DataPageDS oldWidget) {
    super.didUpdateWidget(oldWidget);
    consumeEvents();
  }

  void consumeEvents() {
    if (widget.clearTextEvt.consume()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) controller.clear();
      });
    }
    String newText = widget.changeTextEvt.consume();
    if (newText != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted)
          controller.value = controller.value.copyWith(text: newText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.waiting2 ? 'Downloading...' : 'Show Error Dialog Example'),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: widget.onChangePage,
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Text('Type a name and save:\n(See error if less than 4 chars)'),
            // TextField(
            //   controller: controller,
            //   onSubmitted: widget.onSaveName,
            // ),
            // Text('Current name: ${widget.name}'),
            // Text('This is a TextField. Click to edit it'),
            // TextField(
            //   controller: controller,
            // ),
            // RaisedButton(
            //   onPressed: widget.onChangeText,
            //   child: Text('Change'),
            // ),
            // RaisedButton(
            //   onPressed: widget.onClearText,
            //   child: Text('Clear'),
            // ),
            // if (widget.waiting)
            //   ModalBarrier(color: Colors.red.withOpacity(0.4)),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MyItem(
                    index: index,
                    onGetDescription: widget.onGetDescription,
                  );
                },
              ),
            )
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
