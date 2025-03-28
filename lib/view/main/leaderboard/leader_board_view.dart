import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';
import 'package:BlockPuzzle/view/base_view.dart';
import 'package:BlockPuzzle/view/main/leaderboard/leader_board_view_model.dart';
import 'package:BlockPuzzle/view/main/leaderboard/widget/view/leaderboardFilters/leaderboard_filters.dart';
import 'package:BlockPuzzle/view/main/leaderboard/widget/view/leaderboard_list_view.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  late final LeaderboardViewModel viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    viewModel = LeaderboardViewModel(repository: context.read())
      ..add(const LeaderboardLoadRequested());

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    viewModel.close();
    super.dispose();
  }

  void _onScroll() {
    // 스크롤이 끝에 도달했을 때 추가 데이터 로드 요청
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !viewModel.state.isBusy) {
      viewModel.add(const LoadMoreLeaderboard());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme; // ThemeService에서 테마 가져오기

    return BaseView<LeaderboardViewModel>(
      routeName: 'leaderboard', // 추가

      viewModel: viewModel,
      builder: (context, viewModel) {
        return Scaffold(
          backgroundColor: theme.color.background, // 테마의 배경색 적용
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 필터 섹션
                LeaderboardFilters(viewModel: viewModel),

                const SizedBox(height: 16),

                // 리더보드 목록
                Expanded(
                  child: LeaderboardListView(
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
