/// piece.dart
/// 테트리스 조각(PieceType)과 조각의 모양(상대 좌표)을 정의하는 파일입니다.
/// rotation(0~3)에 따라 각 조각의 상대적 형태를 제공하는 함수를 구현하여,
/// BLoC 혹은 ViewModel에서 활용할 수 있도록 합니다.
library;

import 'package:tetris_app/models/tetrimino/position.dart';

/// 테트리스 조각 유형을 열거형으로 정의합니다.
enum PieceType { I, O, T, S, Z, J, L }

/// 주어진 조각 유형(pieceType)과 회전 상태(rotation)에 따라
/// 상대 좌표를 반환합니다.
///
/// rotation은 0~3 범위를 가지며, 0은 기본 상태,
/// 1~3은 시계 방향으로 90도씩 회전한 상태를 의미합니다.
///
/// 반환되는 리스트는 각 블록의 상대 좌표(0,0)을 기준으로
/// (x, y) 형태로 구성됩니다.
List<Position> getTetriminoShape(PieceType pieceType, int rotation) {
  // 각 조각마다 rotation(0~3)에 따른 상대 좌표를 정의합니다.
  // (0,0)을 기준으로 위쪽/오른쪽 방향으로 좌표계를 잡았다고 가정
  // 테트리스에서는 y가 위->아래 증가 방향이므로, 필요 시 y 축을 반전할 수도 있음.
  switch (pieceType) {
    case PieceType.I:
      // I 모양 (4칸 일자)
      // rotation: 0 => 수평, 1 => 수직 (이하 반복)
      switch (rotation % 4) {
        case 0: // 가로 방향
          return [
            Position(0, 0),
            Position(1, 0),
            Position(2, 0),
            Position(3, 0),
          ];
        case 1: // 세로 방향
          return [
            Position(0, 0),
            Position(0, 1),
            Position(0, 2),
            Position(0, 3),
          ];
        case 2: // 가로 방향 (뒤집힘)
          return [
            Position(0, 0),
            Position(1, 0),
            Position(2, 0),
            Position(3, 0),
          ];
        case 3: // 세로 방향 (반대)
          return [
            Position(0, 0),
            Position(0, 1),
            Position(0, 2),
            Position(0, 3),
          ];
      }

    case PieceType.O:
      // O 모양 (정사각형 2x2)
      // 회전해도 동일
      return [Position(0, 0), Position(1, 0), Position(0, 1), Position(1, 1)];

    case PieceType.T:
      switch (rotation % 4) {
        case 0:
          return [
            Position(0, 0),
            Position(1, 0),
            Position(2, 0),
            Position(1, 1),
          ];
        case 1:
          return [
            Position(0, 1),
            Position(0, 0),
            Position(0, 2),
            Position(1, 1),
          ];
        case 2:
          return [
            Position(0, 1),
            Position(1, 1),
            Position(2, 1),
            Position(1, 0),
          ];
        case 3:
          return [
            Position(1, 0),
            Position(1, 1),
            Position(1, 2),
            Position(0, 1),
          ];
      }

    case PieceType.S:
      switch (rotation % 4) {
        case 0:
        case 2:
          return [
            Position(1, 0),
            Position(2, 0),
            Position(0, 1),
            Position(1, 1),
          ];
        case 1:
        case 3:
          return [
            Position(0, 0),
            Position(0, 1),
            Position(1, 1),
            Position(1, 2),
          ];
      }

    case PieceType.Z:
      switch (rotation % 4) {
        case 0:
        case 2:
          return [
            Position(0, 0),
            Position(1, 0),
            Position(1, 1),
            Position(2, 1),
          ];
        case 1:
        case 3:
          return [
            Position(1, 0),
            Position(0, 1),
            Position(1, 1),
            Position(0, 2),
          ];
      }

    case PieceType.J:
      switch (rotation % 4) {
        case 0:
          return [
            Position(0, 0),
            Position(0, 1),
            Position(1, 0),
            Position(2, 0),
          ];
        case 1:
          return [
            Position(0, 0),
            Position(0, 1),
            Position(0, 2),
            Position(1, 0),
          ];
        case 2:
          return [
            Position(0, 1),
            Position(1, 1),
            Position(2, 1),
            Position(2, 0),
          ];
        case 3:
          return [
            Position(0, 2),
            Position(1, 2),
            Position(1, 1),
            Position(1, 0),
          ];
      }

    case PieceType.L:
      switch (rotation % 4) {
        case 0:
          return [
            Position(2, 0),
            Position(0, 0),
            Position(1, 0),
            Position(2, 1),
          ];
        case 1:
          return [
            Position(0, 0),
            Position(0, 1),
            Position(0, 2),
            Position(1, 2),
          ];
        case 2:
          return [
            Position(0, 0),
            Position(0, 1),
            Position(1, 1),
            Position(2, 1),
          ];
        case 3:
          return [
            Position(0, 0),
            Position(1, 0),
            Position(1, 1),
            Position(1, 2),
          ];
      }
  }
  // 만약 모든 케이스가 처리되지 않았다면 예외 발생
  throw UnimplementedError(
    'Unhandled pieceType: $pieceType, rotation: $rotation',
  );
}
