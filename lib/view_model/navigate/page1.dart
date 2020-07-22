import 'package:apply_asyncredux/states/app_state.dart';
import 'package:apply_asyncredux/user_interface/navigate/page1_ds.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class ViewModel extends BaseModel<AppState> {
  Function() onChangePage;
  ViewModel();
  ViewModel.build({
    @required this.onChangePage,
  });
  @override
  ViewModel fromStore() => ViewModel.build(
        onChangePage: () => dispatch(NavigateAction.pop()),
      );
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => Page1DS(
        onChangePage: vm.onChangePage,
      ),
    );
  }
}
