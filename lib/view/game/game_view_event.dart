/// game_view_event.dart
/// 게임 진행 중 발생하는 이벤트들을 정의합니다.
/// Bloc/ViewModel에서 해당 이벤트를 받아 처리함.
///
/// - GameInitialized: 게임 시작 및 초기화
/// - GameTicked: 일정 주기로 자동 낙하(타이머 이벤트)
/// - PieceMoved: 플레이어가 지정한 방향(왼쪽, 오른쪽, 아래쪽)으로 이동
/// - PieceRotated: 조각을 90도 회전
library;

import 'package:equatable/equatable.dart';
import 'package:tetris_app/models/tetrimino/direction.dart';

abstract class GameViewEvent extends Equatable {
  const GameViewEvent();

  @override
  List<Object?> get props => [];
}

/// 게임을 초기화하고, 첫 번째 조각을 생성하여 낙하를 시작하는 이벤트
class GameInitialized extends GameViewEvent {
  const GameInitialized();
}

/// 게임 틱 (정기적 업데이트) 이벤트
/// 일정 간격마다 발생하여, 조각이 자동으로 1칸씩 하강하도록 함
class GameTicked extends GameViewEvent {
  const GameTicked();
}

/// 사용자가 좌/우/하 이동을 입력했을 때 발생
/// Direction 파라미터(left, right, down)를 활용
class PieceMoved extends GameViewEvent {
  final Direction direction;
  const PieceMoved(this.direction);

  @override
  List<Object?> get props => [direction];
}

/// 사용자가 조각 회전을 입력했을 때 발생
class PieceRotated extends GameViewEvent {
  const PieceRotated();
}
