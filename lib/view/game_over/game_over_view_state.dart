import 'package:BlockPuzzle/view/base_view_state.dart';
import 'package:equatable/equatable.dart';

enum ServerSaveStatus { idle, success, failure }

class GameOverViewState extends BaseViewState with EquatableMixin {
  final int finalScore;
  final ServerSaveStatus serverSaveStatus;

  const GameOverViewState({
    required super.isBusy,
    required this.finalScore,
    this.serverSaveStatus = ServerSaveStatus.idle, // 기본값 설정
  });

  factory GameOverViewState.initial() {
    return const GameOverViewState(
      isBusy: false,
      finalScore: 0,
      serverSaveStatus: ServerSaveStatus.idle, // 초기 상태 설정
    );
  }

  GameOverViewState copyWith({
    bool? isBusy,
    int? finalScore,
    ServerSaveStatus? serverSaveStatus,
  }) {
    return GameOverViewState(
      isBusy: isBusy ?? this.isBusy,
      finalScore: finalScore ?? this.finalScore,
      serverSaveStatus: serverSaveStatus ?? this.serverSaveStatus,
    );
  }

  @override
  List<Object> get props => [isBusy, finalScore, serverSaveStatus];
}
