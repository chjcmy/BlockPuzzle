import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/view/base_view.dart';
import 'package:tetris_app/view/leaderboard/leader_board_view_model.dart';
import 'package:tetris_app/view/leaderboard/widget/leaderboard_bottom_bar.dart';
import 'package:tetris_app/view/leaderboard/widget/view/leaderboardFilters/leaderboard_filters.dart';
import 'package:tetris_app/view/leaderboard/widget/view/leaderboard_list_view.dart';

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
    return BaseView<LeaderboardViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(title: const Text('Leaderboard')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeaderboardFilters(viewModel: viewModel),

                // 리더보드 목록
                Expanded(
                  child: LeaderboardListView(
                    scrollController: _scrollController,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const LeaderboardBottomBar(),
        );
      },
    );
  }
}
