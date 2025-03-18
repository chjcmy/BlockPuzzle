// part 'score_state.dart'
part of 'score_service.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object?> get props => [];
}

class ScoreInitial extends ScoreState {}

class ScoreLoading extends ScoreState {}

class ScoreLoaded extends ScoreState {
  final List<Score> scores;
  const ScoreLoaded(this.scores);

  @override
  List<Object?> get props => [scores];
}

class ScoreError extends ScoreState {
  final String message;
  const ScoreError(this.message);

  @override
  List<Object?> get props => [message];
}
