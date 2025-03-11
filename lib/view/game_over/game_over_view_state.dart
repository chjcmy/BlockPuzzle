import 'package:equatable/equatable.dart';
import 'package:tetris_app/view/base_view_state.dart';

class GameOverViewState extends BaseViewState with EquatableMixin {
  final int finalScore;

  const GameOverViewState({required super.isBusy, required this.finalScore});

  factory GameOverViewState.initial() {
    // 초기 상태: isBusy=false, score=0
    return const GameOverViewState(isBusy: false, finalScore: 0);
  }

  GameOverViewState copyWith({bool? isBusy, int? finalScore}) {
    return GameOverViewState(
      isBusy: isBusy ?? this.isBusy,
      finalScore: finalScore ?? this.finalScore,
    );
  }

  @override
  List<Object> get props => [isBusy, finalScore];
}
