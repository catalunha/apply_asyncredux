import 'package:apply_asyncredux/states/app_state.dart';
import 'package:apply_asyncredux/user_interface/data/my_item_ds.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class ViewModel extends BaseModel<AppState> {
  int index;
  String description;
  bool waiting;
  ViewModel({this.index});
  ViewModel.build({
    @required this.description,
    @required this.waiting,
  }) : super(equals: [description, waiting]);

  @override
  ViewModel fromStore() => ViewModel.build(
        description: state.dataState.descriptions[index],
        waiting: state.wait.isWaitingFor(index),
      );
}

class MyItem extends StatelessWidget {
  final int index;
  final void Function(int) onGetDescription;

  const MyItem({Key key, this.index, this.onGetDescription}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(index: index),
      builder: (context, vm) => MyItemDS(
        index: index,
        onGetDescription: onGetDescription,
        description: vm.description,
        waiting: vm.waiting,
      ),
    );
  }
}
