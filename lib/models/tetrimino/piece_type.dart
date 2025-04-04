/// piece.dart
/// 테트리스 조각(PieceType)과 조각의 모양(상대 좌표)을 정의하는 파일입니다.
/// rotation(0~3)에 따라 각 조각의 상대적 형태를 제공하는 함수를 구현하여,
/// BLoC 혹은 ViewModel에서 활용할 수 있도록 합니다.
library;

import 'package:BlockPuzzle/models/tetrimino/position.dart';

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
  switch (pieceType) {
    case PieceType.I:
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

/// SRS 오프셋 정의
/// 각 조각과 회전 상태에 따라 적용할 오프셋 리스트를 정의합니다.
const Map<PieceType, Map<int, List<Position>>> SRS_OFFSETS = {
  PieceType.I: {
    0: [
      Position(0, 0),
      Position(-1, 0),
      Position(2, 0),
      Position(-1, -1),
      Position(2, 1),
    ],
    1: [
      Position(0, 0),
      Position(1, 0),
      Position(-2, 0),
      Position(1, 1),
      Position(-2, -1),
    ],
    2: [
      Position(0, 0),
      Position(2, 0),
      Position(-1, 0),
      Position(2, -1),
      Position(-1, 1),
    ],
    3: [
      Position(0, 0),
      Position(-2, 0),
      Position(1, 0),
      Position(-2, 1),
      Position(1, -1),
    ],
  },
  PieceType.T: {
    0: [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(-1, 1),
      Position(1, -1),
    ],
    1: [
      Position(0, 0),
      Position(1, 0),
      Position(-1, 0),
      Position(1, -1),
      Position(-1, 1),
    ],
    2: [
      Position(0, 0),
      Position(1, 0),
      Position(-1, 0),
      Position(1, 1),
      Position(-1, -1),
    ],
    3: [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(-1, -1),
      Position(1, 1),
    ],
  },
  PieceType.S: {
    0: [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(0, -1),
      Position(1, -1),
    ],
    1: [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
      Position(-1, 1),
      Position(-1, -1),
    ],
    2: [
      Position(0, 0),
      Position(1, 0),
      Position(-1, 0),
      Position(0, 1),
      Position(-1, 1),
    ],
    3: [
      Position(0, 0),
      Position(0, -1),
      Position(0, 1),
      Position(1, -1),
      Position(1, 1),
    ],
  },
  PieceType.Z: {
    0: [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(0, -1),
      Position(-1, -1),
    ],
    1: [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
      Position(1, 1),
      Position(1, -1),
    ],
    2: [
      Position(0, 0),
      Position(1, 0),
      Position(-1, 0),
      Position(0, 1),
      Position(1, 1),
    ],
    3: [
      Position(0, 0),
      Position(0, -1),
      Position(0, 1),
      Position(-1, -1),
      Position(-1, 1),
    ],
  },
  PieceType.J: {
    0: [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(-1, -1),
      Position(1, -1),
    ],
    1: [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
      Position(-1, 1),
      Position(-1, -1),
    ],
    2: [
      Position(0, 0),
      Position(1, 0),
      Position(-1, 0),
      Position(1, 1),
      Position(-1, 1),
    ],
    3: [
      Position(0, 0),
      Position(0, -1),
      Position(0, 1),
      Position(1, -1),
      Position(1, 1),
    ],
  },
  PieceType.L: {
    0: [
      Position(0, 0),
      Position(-1, 0),
      Position(1, 0),
      Position(-1, -1),
      Position(1, -1),
    ],
    1: [
      Position(0, 0),
      Position(0, 1),
      Position(0, -1),
      Position(1, 1),
      Position(1, -1),
    ],
    2: [
      Position(0, 0),
      Position(1, 0),
      Position(-1, 0),
      Position(1, 1),
      Position(-1, 1),
    ],
    3: [
      Position(0, 0),
      Position(0, -1),
      Position(0, 1),
      Position(-1, -1),
      Position(-1, 1),
    ],
  },
  PieceType.O: {
    // O 조각은 회전해도 모양이 변하지 않으므로 오프셋이 필요 없음
    0: [Position(0, 0)],
    1: [Position(0, 0)],
    2: [Position(0, 0)],
    3: [Position(0, 0)],
  },
};
