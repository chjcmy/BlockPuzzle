import 'package:equatable/equatable.dart';

abstract class GameOverEvent extends Equatable {
  const GameOverEvent();

  @override
  List<Object?> get props => [];
}

// 게임 오버 화면이 열릴 때, 마지막 점수를 전달하기 위한 이벤트
class GameOverInitialized extends GameOverEvent {
  final int lastScore;
  const GameOverInitialized(this.lastScore);

  @override
  List<Object?> get props => [lastScore];
}