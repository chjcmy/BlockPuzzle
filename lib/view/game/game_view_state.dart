/// game_view_state.dart
/// 게임 화면의 상태를 표현하는 클래스입니다.
/// BaseViewState를 상속받고 EquatableMixin을 사용하여
/// 상태 비교 및 관리가 용이하도록 구성합니다.
///
/// - grid: 고정된 블록들의 위치를 저장하는 해시맵 (key: "x,y", value: bool)
/// - activePiece: 현재 떨어지고 있는 조각의 종류 (PieceType)
/// - activePieceRotation: 현재 조각의 회전 상태 (0~3)
/// - activePiecePosition: 보드 내에서 조각의 기준 위치
/// - activePiecePositions: 조각을 구성하는 블록들의 실제 좌표
/// - nextPieces: 다음에 떨어질 조각들을 미리 생성하여 큐 형태로 관리
/// - score: 점수
/// - level: 게임 레벨 (기본 1, 점수에 따라 자동 증가)
/// - speed: 하강 속도 (기본 1.0, 누적 100점마다 0.1씩 증가)
/// - gameRunning: 게임 진행 여부
/// - gameOver: 게임 오버 여부
library;

import 'package:equatable/equatable.dart';
import 'package:tetris_app/models/tetrimino/piece_type.dart';
import 'package:tetris_app/models/tetrimino/position.dart';
import 'package:tetris_app/view/base_view_state.dart';

class GameViewState extends BaseViewState with EquatableMixin {
  /// 고정된 블록이 있는 위치를 저장합니다.
  /// key: "x,y" 문자열, value: 블록 존재 여부
  final Map<String, bool> grid;

  /// 현재 활성 조각 (I, O, T, S, Z, J, L 등)
  final PieceType? activePiece;

  /// 조각의 회전 상태 (0~3)
  final int activePieceRotation;

  /// 조각의 기준 위치 (상단 좌표)
  final Position activePiecePosition;

  /// 현재 활성 조각을 구성하는 모든 블록의 좌표
  final List<Position> activePiecePositions;

  /// 다음에 떨어질 조각들의 목록
  final List<PieceType> nextPieces;

  /// 플레이어의 점수
  final int score;

  /// 게임 레벨 (누적 점수 100점마다 1 증가)
  final int level;

  /// 블록 하강 속도 (1.0에서 시작, 0.1씩 증가)
  final double speed;

  /// 게임 진행 여부
  final bool gameRunning;

  /// 게임 오버 여부
  final bool gameOver;

  const GameViewState({
    required super.isBusy,
    required this.grid,
    this.activePiece,
    this.activePieceRotation = 0,
    required this.activePiecePosition,
    required this.activePiecePositions,
    required this.nextPieces,
    this.score = 0,
    this.level = 1,
    this.speed = 1.0,
    this.gameRunning = false,
    this.gameOver = false,
  });

  /// copyWith 메서드를 통해 특정 필드만 변경하여 새 상태를 만들 수 있습니다.
  GameViewState copyWith({
    Map<String, bool>? grid,
    PieceType? activePiece,
    int? activePieceRotation,
    Position? activePiecePosition,
    List<Position>? activePiecePositions,
    List<PieceType>? nextPieces,
    int? score,
    int? level,
    double? speed,
    bool? gameRunning,
    bool? gameOver,
    bool? isBusy,
  }) {
    return GameViewState(
      isBusy: isBusy ?? this.isBusy,
      grid: grid ?? this.grid,
      activePiece: activePiece ?? this.activePiece,
      activePieceRotation: activePieceRotation ?? this.activePieceRotation,
      activePiecePosition: activePiecePosition ?? this.activePiecePosition,
      activePiecePositions: activePiecePositions ?? this.activePiecePositions,
      nextPieces: nextPieces ?? this.nextPieces,
      score: score ?? this.score,
      level: level ?? this.level,
      speed: speed ?? this.speed,
      gameRunning: gameRunning ?? this.gameRunning,
      gameOver: gameOver ?? this.gameOver,
    );
  }

  @override
  List<Object?> get props => [
    grid,
    activePiece,
    activePieceRotation,
    activePiecePosition,
    activePiecePositions,
    nextPieces,
    score,
    level,
    speed,
    gameRunning,
    gameOver,
    isBusy,
  ];
}
