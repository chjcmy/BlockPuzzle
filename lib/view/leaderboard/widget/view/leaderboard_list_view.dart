import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/view/leaderboard/leader_board_view_model.dart';
import 'package:tetris_app/view/leaderboard/widget/leaderboard_list.dart';

class LeaderboardListView extends StatelessWidget {
  final ScrollController scrollController;

  const LeaderboardListView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardViewModel, LeaderboardState>(
      buildWhen:
          (previous, current) =>
              previous.entries != current.entries ||
              previous.isBusy != current.isBusy,
      builder: (context, state) {
        return state.isBusy && state.entries.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : LeaderboardList(
              entries: state.entries,
              scrollController: scrollController,
              isLoading: state.isBusy,
            );
      },
    );
  }
}
