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
  bool waiting2;
  void Function(int) onGetDescription;
  List<String> numTrivias;
  bool isLoading;
  Function() onLoadMore;
  Future<void> Function() onRefresh;
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
    @required this.waiting2,
    @required this.onGetDescription,
    @required this.numTrivias,
    @required this.isLoading,
    @required this.onLoadMore,
    @required this.onRefresh,
  }) : super(equals: [
          name,
          waiting,
          clearTextEvt,
          changeTextEvt,
          waiting2,
          numTrivias,
          isLoading,
        ]);

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
        waiting2: state.wait.isWaiting,
        onGetDescription: (int index) =>
            dispatch(GetDescriptionDataAction(index)),
        numTrivias: state.dataState.numTrivias,
        isLoading: state.dataState.isLoading,
        onLoadMore: () => dispatch(LoadMoreDataAction()),
        onRefresh: () => dispatchFuture(RefreshDataAction()),
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
        waiting2: vm.waiting2,
        onGetDescription: vm.onGetDescription,
        numTrivias: vm.numTrivias,
        isLoading: vm.isLoading,
        onLoadMore: vm.onLoadMore,
        onRefresh: vm.onRefresh,
      ),
      debug: this,
      onInit: (store) => store.dispatch(RefreshDataAction()),
    );
  }
}
