part of 'score_service.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object?> get props => [];
}

class LoadScores extends ScoreEvent {}

class DeleteAllScores extends ScoreEvent {}

class ScoreUpdated extends ScoreEvent {}

class SortScores extends ScoreEvent {
  final ScoreSortType sortType;
  const SortScores(this.sortType);

  @override
  List<Object?> get props => [sortType];
}