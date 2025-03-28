import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/view/main/leaderboard/leader_board_view_model.dart';
import 'package:BlockPuzzle/view/main/leaderboard/widget/leaderboard_list.dart';

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
        if (state.isBusy && state.entries.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return LeaderboardList(
          entries: state.entries,
          scrollController: scrollController,
          isLoading: state.isBusy,
        );
      },
    );
  }
}
