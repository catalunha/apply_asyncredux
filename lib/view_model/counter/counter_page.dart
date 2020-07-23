import 'package:apply_asyncredux/user_interface/counter/counter_page_ds.dart';
import 'package:async_redux/async_redux.dart';
import 'package:apply_asyncredux/actions/counter_actions.dart';
import 'package:apply_asyncredux/states/app_state.dart';
import 'package:flutter/material.dart';

class ViewModel extends BaseModel<AppState> {
  int counter;
  String description;
  bool waiting;
  Function() onIncrement;

  ViewModel();
  ViewModel.build({
    @required this.counter,
    @required this.description,
    @required this.waiting,
    @required this.onIncrement,
  }) : super(equals: [counter, description, waiting]);

  @override
  ViewModel fromStore() => ViewModel.build(
      counter: state.counterState.counter,
      description: state.counterState.descriptionNumber,
      // waiting: state.counterState.waiting,
      waiting: state.wait.isWaiting,
      onIncrement: () {
        // dispatch(IncrementCounterAction(amount: 1));
        dispatch(IncrementAndGetDescriptionCounterAction());
      });
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => CounterPageDS(
        counter: vm.counter,
        description: vm.description,
        waiting: vm.waiting,
        onIncrement: vm.onIncrement,
      ),
      distinct: true,
    );
  }
}

// class ViewModel {
//   final int counter;
//   final Function onIncrement;
//   final int factorial;

//   ViewModel({
//     this.onIncrement,
//     this.counter,
//     this.factorial,
//   });

//   static ViewModel fromStore(Store<AppState> store) {
//     return ViewModel(
//       onIncrement: () => store.dispatch(IncrementCounterAction(amount: 1)),
//       counter: store.state.counterState.counter,
//       // factorial: factorialCounterSelector(store.state.counterState),
//     );
//   }
// }

// class CounterPage extends StatelessWidget {
//   final String title;
//   const CounterPage({Key key, this.title = 'teste'}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, ViewModel>(
//       converter: ViewModel.fromStore,
//       builder: (context, viewModel) {
//         return CounterPageDS(
//           // title: title,
//           counter: viewModel.counter,
//           onIncrement: viewModel.onIncrement,
//           // factorial: viewModel.factorial,
//         );
//       },
//     );
//   }
// }
