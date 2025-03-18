// home_view_event.dart
part of 'home_view_model.dart';

abstract class HomeViewEvent extends Equatable {
  const HomeViewEvent();

  @override
  List<Object?> get props => [];
}

/// 점수 목록을 로드하라는 이벤트
class LoadScoreList extends HomeViewEvent {
  const LoadScoreList();
}

/// 점수 목록의 정렬 방식을 변경하라는 이벤트
class SortScoreList extends HomeViewEvent {
  final ScoreSortType sortType;
  const SortScoreList(this.sortType);

  @override
  List<Object?> get props => [sortType];
}

class LoadSeasonData extends HomeViewEvent {
  const LoadSeasonData();
}
