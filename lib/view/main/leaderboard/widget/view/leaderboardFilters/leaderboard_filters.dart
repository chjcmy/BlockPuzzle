import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/view/main/leaderboard/leader_board_view_model.dart';
import 'package:BlockPuzzle/view/main/leaderboard/widget/leaderboard_search_bar.dart';
import 'package:BlockPuzzle/view/main/leaderboard/widget/season_selector.dart';
import 'package:BlockPuzzle/view/main/leaderboard/widget/year_selector.dart';

class LeaderboardFilters extends StatelessWidget {
  final LeaderboardViewModel viewModel;

  const LeaderboardFilters({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return BlocBuilder<LeaderboardViewModel, LeaderboardState>(
      bloc: viewModel,
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
              Text(
                '연도 선택',
                style: theme.typo.bodyText1, // 테마의 본문 스타일 적용
              ),
              const SizedBox(height: 8),
              YearSelector(
                years: state.availableYears,
                selectedYear: state.selectedYear,
                onYearSelected: (year) => viewModel.add(YearSelected(year)),
              ),

              const SizedBox(height: 16),

              // 시즌 선택 섹션
              Text(
                '시즌 선택',
                style: theme.typo.bodyText1, // 테마의 본문 스타일 적용
              ),
              const SizedBox(height: 8),
              SeasonSelector(
                seasons: state.availableSeasons,
                selectedSeasons: state.selectedSeasons,
                onSeasonSelected:
                    (season) => viewModel.add(SeasonSelected(season)),
              ),

              const SizedBox(height: 16),

              // 검색 바
              LeaderboardSearchBar(
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
