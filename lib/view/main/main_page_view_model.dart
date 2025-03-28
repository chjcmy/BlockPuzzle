import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageViewModel extends Cubit<int> {
  MainPageViewModel() : super(0);

  void updateIndex(int index) {
    emit(index);
  }
}
