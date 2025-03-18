import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/view/leaderboard/leader_board_view_model.dart';
import 'package:tetris_app/view/leaderboard/widget/leaderboard_search_bar.dart';
import 'package:tetris_app/view/leaderboard/widget/season_selector.dart';
import 'package:tetris_app/view/leaderboard/widget/year_selector.dart';

class LeaderboardFilters extends StatelessWidget {
  final LeaderboardViewModel viewModel;

  const LeaderboardFilters({super.key, required this.viewModel});

  final bool _searchEnabled = false;

  @override
  Widget build(BuildContext context) {
    // BlocBuilder를 사용하여 필요한 상태만 구독
    return BlocBuilder<LeaderboardViewModel, LeaderboardState>(
      bloc: viewModel,
      // buildWhen을 사용하여 필요한 상태 변경 시에만 리빌드
      buildWhen:
          (previous, current) =>
              previous.availableYears != current.availableYears ||
              previous.availableSeasons != current.availableSeasons ||
              previous.selectedYear != current.selectedYear ||
              previous.selectedSeasons != current.selectedSeasons,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 연도 선택 섹션
              YearSelector(
                years: state.availableYears,
                selectedYear: state.selectedYear,
                onYearSelected: (year) => viewModel.add(YearSelected(year)),
              ),
              const SizedBox(height: 16),
              // 시즌 선택 섹션
              SeasonSelector(
                seasons: state.availableSeasons,
                selectedSeasons: state.selectedSeasons,
                onSeasonSelected:
                    (season) => viewModel.add(SeasonSelected(season)),
              ),
              LeaderboardSearchBar(
                enabled: _searchEnabled,
                onSearchChanged:
                    (text) => viewModel.add(LeaderboardSearchChanged(text)),
              ),
            ],
          ),
        );
      },
    );
  }
}
