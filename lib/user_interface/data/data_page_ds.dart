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
  final List<String> numTrivias;
  final bool isLoading;
  final Function() onLoadMore;
  final Future<void> Function() onRefresh;
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
    this.numTrivias,
    this.isLoading,
    this.onLoadMore,
    this.onRefresh,
  }) : super(key: key);
  @override
  _DataPageDSState createState() => _DataPageDSState();
}

class _DataPageDSState extends State<DataPageDS> {
  TextEditingController controller;
  ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        if (!widget.isLoading &&
            scrollController.position.maxScrollExtent ==
                scrollController.position.pixels) {
          widget.onLoadMore();
        }
      });
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
      body: (widget.numTrivias == null || widget.numTrivias.isEmpty)
          ? Container()
          : RefreshIndicator(
              onRefresh: widget.onRefresh,
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.numTrivias.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      index.toString(),
                    ),
                  ),
                  title: Text(widget.numTrivias[index]),
                ),
              ),
            ),
    );

    // body: Center(
    //   child: Column(
    //     children: [
    //       // Text('Type a name and save:\n(See error if less than 4 chars)'),
    //       // TextField(
    //       //   controller: controller,
    //       //   onSubmitted: widget.onSaveName,
    //       // ),
    //       // Text('Current name: ${widget.name}'),
    //       // Text('This is a TextField. Click to edit it'),
    //       // TextField(
    //       //   controller: controller,
    //       // ),
    //       // RaisedButton(
    //       //   onPressed: widget.onChangeText,
    //       //   child: Text('Change'),
    //       // ),
    //       // RaisedButton(
    //       //   onPressed: widget.onClearText,
    //       //   child: Text('Clear'),
    //       // ),
    //       // if (widget.waiting)
    //       //   ModalBarrier(color: Colors.red.withOpacity(0.4)),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: 10,
    //           itemBuilder: (context, index) {
    //             return MyItem(
    //               index: index,
    //               onGetDescription: widget.onGetDescription,
    //             );
    //           },
    //         ),
    //       )
    //     ],
    //   ),
    // ),
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () => widget.onSaveName(controller.text),
    //   child: Text('Save'),
    // ),
    // );
  }
}
