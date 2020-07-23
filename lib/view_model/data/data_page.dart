import 'package:apply_asyncredux/actions/data_actions.dart';
import 'package:apply_asyncredux/states/app_state.dart';
import 'package:apply_asyncredux/user_interface/data/data_page_ds.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  Function(String) onSaveName;
  Function onChangePage;
  bool waiting;
  Event clearTextEvt;
  Event<String> changeTextEvt;
  Function onClearText;
  Function onChangeText;
  ViewModel();
  ViewModel.build({
    @required this.name,
    @required this.onSaveName,
    @required this.onChangePage,
    @required this.waiting,
    @required this.clearTextEvt,
    @required this.changeTextEvt,
    @required this.onClearText,
    @required this.onChangeText,
  }) : super(equals: [name, waiting, clearTextEvt, changeTextEvt]);
  @override
  ViewModel fromStore() => ViewModel.build(
        name: state.dataState.name,
        onSaveName: (String name) {
          dispatch(SaveUserDataAction(name));
          // dispatch(UserExceptionAction('Saving $name'));
        },
        onChangePage: () => dispatch(NavigateAction.pushNamed('/page1')),
        waiting: state.dataState.waiting,
        clearTextEvt: state.dataState.clearTextEvt,
        changeTextEvt: state.dataState.changeTextEvt,
        onClearText: () => dispatch(ClearTextDataAction()),
        onChangeText: () => dispatch(ChangeTextDataAction()),
      );
}

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DataPageDS(
        name: vm.name,
        onSaveName: vm.onSaveName,
        onChangePage: vm.onChangePage,
        waiting: vm.waiting,
        clearTextEvt: vm.clearTextEvt,
        changeTextEvt: vm.changeTextEvt,
        onClearText: vm.onClearText,
        onChangeText: vm.onChangeText,
      ),
    );
  }
}
