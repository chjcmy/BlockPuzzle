import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/view/base_view_state.dart';

class BaseViewModel<E, S extends BaseViewState> extends Bloc<E, S> {
  BaseViewModel(super.initialState);
}