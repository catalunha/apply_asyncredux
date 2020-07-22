import 'package:apply_asyncredux/actions/data_actions.dart';
import 'package:apply_asyncredux/states/app_state.dart';
import 'package:apply_asyncredux/user_interface/data/data_page_ds.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';

class ViewModel extends BaseModel<AppState> {
  String name;
  Function(String) onSaveName;
  Function onChangePage;
  ViewModel();
  ViewModel.build({
    @required this.name,
    @required this.onSaveName,
    @required this.onChangePage,
  }) : super(equals: [name]);
  @override
  ViewModel fromStore() => ViewModel.build(
        name: state.dataState.name,
        onSaveName: (String name) {
          dispatch(SaveUserDataAction(name));
          // dispatch(UserExceptionAction('Saving $name'));
        },
        onChangePage: () => dispatch(NavigateAction.pushNamed('/page1')),
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
      ),
    );
  }
}
