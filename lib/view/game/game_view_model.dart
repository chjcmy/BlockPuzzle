/// game_view_model.dart
/// BLoC 패턴을 구현하기 위한 ViewModel 클래스
/// BaseViewModel<GameViewEvent, GameViewState>를 상속받고,
/// 테트리스 게임 로직(이벤트 핸들러, 충돌 검사, 라인 제거 등)을 담당합니다.
///
/// [핵심 기능]
/// 1) 게임 초기화 및 시작 (GameInitialized)
/// 2) 정기적 자동 낙하 처리 (GameTicked)
/// 3) 사용자 입력에 따른 조각 이동 (PieceMoved)
/// 4) 조각 회전 처리 (PieceRotated)
/// 5) 충돌 검사, 라인 완성 검사, 점수 및 속도 업데이트
library;

import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/models/tetrimino/direction.dart';
import 'package:tetris_app/models/tetrimino/piece_type.dart';
import 'package:tetris_app/models/tetrimino/position.dart';
import 'package:tetris_app/view/base_view_model.dart';
import 'package:tetris_app/view/game/game_view_event.dart';
import 'package:tetris_app/view/game/game_view_state.dart';

class GameViewModel extends BaseViewModel<GameViewEvent, GameViewState> {
  // 게임 보드의 폭과 높이 (10 x 20)
  static const int GRID_WIDTH = 10;
  static const int GRID_HEIGHT = 20;

  /// 타이머를 통해 주기적으로 GameTicked 이벤트를 발생시킵니다.
  Timer? _gameTimer;

  GameViewModel()
    : super(
        // 초기 상태 정의
        GameViewState(
          isBusy: false,
          grid: {},
          activePiecePosition: Position(0, 0),
          activePiecePositions: [],
          nextPieces: [],
        ),
      ) {
    // 이벤트 핸들러 등록
    on<GameInitialized>(_onGameInitialized);
    on<GameTicked>(_onGameTicked);
    on<PieceMoved>(_onPieceMoved);
    on<PieceRotated>(_onPieceRotated);
  }

  @override
  Future<void> close() {
    // ViewModel 해제 시 타이머도 취소
    _gameTimer?.cancel();
    return super.close();
  }

  /// [GameInitialized] 이벤트 처리 메서드
  /// 게임을 초기화하고, 새 조각 및 다음 조각들을 생성 후 타이머 시작
  void _onGameInitialized(GameInitialized event, Emitter<GameViewState> emit) {
    _gameTimer?.cancel();
    final random = Random();

    // 4개의 조각을 미리 생성하여, 첫 번째를 활성 조각으로 쓰고 나머지는 nextPieces에 저장
    final initialPieces = List.generate(
      4,
      (_) => PieceType.values[random.nextInt(PieceType.values.length)],
    );
    final initialPiece = initialPieces.first;
    final nextPieces = initialPieces.sublist(1);

    // 활성 조각을 보드의 최상단(또는 중앙) 부근에 두기 위한 위치
    // 이번 예시에선 y를 (GRID_HEIGHT)로 잡아 아래에서부터 쌓이듯 표현하거나,
    // 0으로 잡아 실제 테트리스와 동일한 상단 스폰 방식을 선택할 수 있음
    final initialPos = Position(GRID_WIDTH ~/ 2 - 1, 0);

    final piecePositions = _calculatePiecePositions(
      initialPiece,
      0,
      initialPos,
    );

    // 새로운 상태
    final newState = state.copyWith(
      isBusy: false,
      grid: {},
      activePiece: initialPiece,
      activePieceRotation: 0,
      activePiecePosition: initialPos,
      activePiecePositions: piecePositions,
      nextPieces: nextPieces,
      score: 0,
      level: 1,
      speed: 1.0,
      gameRunning: true,
      gameOver: false,
    );
    emit(newState);

    // 타이머 시작: speed에 따라 주기를 조정
    _gameTimer = Timer.periodic(
      Duration(milliseconds: (1000 / newState.speed).round()),
      (_) => add(const GameTicked()),
    );
  }

  /// [GameTicked] 이벤트 처리 메서드
  /// 일정 간격으로 호출되며, 조각을 1칸씩 자동 하강시킴
  /// 하단 충돌 시 조각을 고정하고 새 조각 생성, 라인 제거 등 처리
  void _onGameTicked(GameTicked event, Emitter<GameViewState> emit) {
    if (!state.gameRunning || state.gameOver) return;

    final currentPos = state.activePiecePosition;
    // y를 1 증가시켜 한 칸 '아래'로 이동
    final newPos = Position(currentPos.x, currentPos.y + 1);

    // 현재 활성 블록 조각들의 위치를 로그로 출력
    print("블록 조각들의 현재 위치:");
    for (final pos in state.activePiecePositions) {
      print(" - x=${pos.x}, y=${pos.y}");
    }

    if (_canMoveTo(state.activePiece!, state.activePieceRotation, newPos)) {
      final newPositions = _calculatePiecePositions(
        state.activePiece!,
        state.activePieceRotation,
        newPos,
      );
      // 정상 이동 가능
      emit(
        state.copyWith(
          activePiecePosition: newPos,
          activePiecePositions: newPositions,
        ),
      );
    } else {
      // 충돌 발생 => 현재 조각을 grid에 고정
      final newGrid = Map<String, bool>.from(state.grid);
      bool gameOver = false; // 새 변수를 선언해두고

      for (final pos in state.activePiecePositions) {
        newGrid['${pos.x},${pos.y}'] = true;
        // y=0인 칸이 하나라도 있다면 게임 오버
        if (pos.y == 0) {
          gameOver = true;
        }
      }

      // 라인 제거
      int linesCleared = _clearFullRows(newGrid);
      // 한 줄 제거당 100점
      int additionalScore = 100 * linesCleared;
      // 누적 100점마다 속도 0.1 증가
      final totalScore = state.score + additionalScore;
      // 고정 후 새 조각 스폰
      final random = Random();
      final nextPiece = state.nextPieces.first;
      final nextPieces = List<PieceType>.from(state.nextPieces.sublist(1))
        ..add(PieceType.values[random.nextInt(PieceType.values.length)]);
      final spawnPos = Position(GRID_WIDTH ~/ 2 - 1, 0);
      final spawnPositions = _calculatePiecePositions(nextPiece, 0, spawnPos);

      // 게임 오버 검사: 새 조각 위치가 이미 차있으면 게임 오버
      for (final pos in spawnPositions) {
        if (newGrid.containsKey('${pos.x},${pos.y}')) {
          gameOver = true;
          break;
        }
      }

      // 속도 업데이트: (score / 100) * 0.1 => 예: 100점마다 0.1 증가
      double newSpeed = 1.0 + (totalScore ~/ 100) * 0.1;

      final newState = state.copyWith(
        grid: newGrid,
        activePiece: nextPiece,
        activePieceRotation: 0,
        activePiecePosition: spawnPos,
        activePiecePositions: spawnPositions,
        nextPieces: nextPieces,
        score: totalScore,
        speed: newSpeed,
        gameRunning: !gameOver,
        gameOver: gameOver,
      );
      emit(newState);

      // 충돌 후 타이머 리셋
      _gameTimer?.cancel();
      if (!gameOver) {
        _gameTimer = Timer.periodic(
          Duration(milliseconds: (1000 / newState.speed).round()),
          (_) => add(const GameTicked()),
        );
      }
    }
  }

  /// [PieceMoved] 이벤트 처리 메서드
  /// 사용자 입력에 따라 조각을 왼쪽, 오른쪽, 아래로 이동
  void _onPieceMoved(PieceMoved event, Emitter<GameViewState> emit) {
    if (!state.gameRunning || state.gameOver) return;
    final pos = state.activePiecePosition;
    Position newPos;
    switch (event.direction) {
      case Direction.left:
        newPos = Position(pos.x - 1, pos.y);
        break;
      case Direction.right:
        newPos = Position(pos.x + 1, pos.y);
        break;
      case Direction.down:
        newPos = Position(pos.x, pos.y + 1);
        break;
    }
    if (_canMoveTo(state.activePiece!, state.activePieceRotation, newPos)) {
      final newPositions = _calculatePiecePositions(
        state.activePiece!,
        state.activePieceRotation,
        newPos,
      );
      emit(
        state.copyWith(
          activePiecePosition: newPos,
          activePiecePositions: newPositions,
        ),
      );
    }
  }

  /// [PieceRotated] 이벤트 처리 메서드
  /// 조각 회전 (activePieceRotation + 1) % 4 => 새 회전 상태
  void _onPieceRotated(PieceRotated event, Emitter<GameViewState> emit) {
    if (!state.gameRunning || state.gameOver) return;
    final newRotation = (state.activePieceRotation + 1) % 4;
    if (_canMoveTo(
      state.activePiece!,
      newRotation,
      state.activePiecePosition,
    )) {
      final newPositions = _calculatePiecePositions(
        state.activePiece!,
        newRotation,
        state.activePiecePosition,
      );
      emit(
        state.copyWith(
          activePieceRotation: newRotation,
          activePiecePositions: newPositions,
        ),
      );
    }
  }

  /// 조각이 특정 위치와 회전 상태로 이동 가능한지 검사
  bool _canMoveTo(PieceType pieceType, int rotation, Position pos) {
    final positions = _calculatePiecePositions(pieceType, rotation, pos);
    for (final p in positions) {
      // 보드 범위를 벗어나면 이동 불가
      // y <= 0 이 아닌 y < 0 으로 수정
      if (p.x < 0 || p.x >= GRID_WIDTH || p.y < 0 || p.y >= GRID_HEIGHT) {
        return false;
      }
      // 이미 고정된 블록과 겹치면 이동 불가
      if (state.grid.containsKey('${p.x},${p.y}')) {
        return false;
      }
    }
    return true;
  }

  /// 조각의 shape(상대 좌표)에 따라 실제 보드 좌표를 계산
  List<Position> _calculatePiecePositions(
    PieceType pieceType,
    int rotation,
    Position pos,
  ) {
    // shape 가져오기 (PieceType에 따라 정의된 상대 좌표, rotation별 변환 등)
    final shape = getTetriminoShape(pieceType, rotation);

    return shape.map((offset) {
      return Position(pos.x + offset.x, pos.y + offset.y);
    }).toList();
  }

  /// 그리드에서 가득 찬 행을 찾아 제거하고, 제거된 행의 개수를 반환
  int _clearFullRows(Map<String, bool> grid) {
    int clearedRows = 0; // <- 여기서 변수를 선언해줍니다.

    // 아래에서 위로 확인 (top=0, bottom=GRID_HEIGHT-1)
    for (int y = GRID_HEIGHT - 1; y >= 0; y--) {
      bool full = true;
      for (int x = 0; x < GRID_WIDTH; x++) {
        if (!grid.containsKey('$x,$y')) {
          full = false;
          break;
        }
      }
      if (full) {
        clearedRows++;
        // 해당 행 제거
        for (int x = 0; x < GRID_WIDTH; x++) {
          grid.remove('$x,$y');
        }
        // 위쪽 블록들을 아래로 이동
        for (int yy = y - 1; yy >= 0; yy--) {
          for (int x = 0; x < GRID_WIDTH; x++) {
            if (grid.remove('$x,$yy') == true) {
              grid['$x,${yy + 1}'] = true;
            }
          }
        }
        // 제거한 후 같은 행을 다시 검사하기 위해
        // y 위치를 1 증가시켜서 직전 반복을 다시 확인
        y++;
      }
    }
    return clearedRows;
  }
}

/// 
/// 아래 예시 shape 데이터나 getTetriminoShape 함수는
/// piece.dart 또는 별도 헬퍼에 구현할 수 있습니다.
/// 예: rotation별로 블록의 상대 좌표를 정의.
/// 
/// List<Position> getTetriminoShape(PieceType pieceType, int rotation) { ... }
///