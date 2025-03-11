import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/view/base_view.dart';
import 'package:tetris_app/view/leaderboard/leader_board_view_model.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  late final LeaderboardViewModel viewModel;
  final ScrollController _scrollController = ScrollController();
  bool _searchEnabled = true; // 검색 기능 활성화 여부

  @override
  void initState() {
    super.initState();
    viewModel = LeaderboardViewModel(repository: context.read())
      ..add(const LeaderboardLoadRequested());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !viewModel.state.isBusy) {
      viewModel.add(const LoadMoreLeaderboard());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LeaderboardViewModel>(
      viewModel: viewModel,
      builder: (context, viewModel) {
        final state = viewModel.state;
        return Scaffold(
          appBar: AppBar(
            title: const Text('전체 순위'),
            actions: [
              IconButton(
                icon: Icon(_searchEnabled ? Icons.search_off : Icons.search),
                onPressed: () {
                  setState(() {
                    _searchEnabled = !_searchEnabled;
                    if (!_searchEnabled) {
                      // 검색 기능 비활성화 시 전체 데이터를 다시 로드
                      viewModel.add(const LeaderboardLoadRequested());
                    }
                  });
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 검색어 입력 필드: _searchEnabled에 따라 활성/비활성
                TextField(
                  enabled: _searchEnabled,
                  decoration: const InputDecoration(
                    labelText: '플레이어 이름 또는 ID로 검색',
                    hintText: '검색어를 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    viewModel.add(LeaderboardSearchChanged(text));
                  },
                ),
                const SizedBox(height: 8),
                // 에러 메시지
                if (state.error != null)
                  Text(
                    '오류 발생: ${state.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 8),
                // 리더보드 목록
                Expanded(
                  child:
                      state.isBusy && state.entries.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            controller: _scrollController,
                            itemCount: state.entries.length + 1,
                            itemBuilder: (context, index) {
                              if (index < state.entries.length) {
                                final entry = state.entries[index];
                                return ListTile(
                                  leading: Text('${entry.rank}'),
                                  title: Text(entry.name),
                                  trailing: Text('점수: ${entry.score}'),
                                );
                              } else {
                                // 마지막 항목: 추가 데이터 로딩 중이면 로딩 인디케이터 표시
                                return state.isBusy
                                    ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                    : const SizedBox();
                              }
                            },
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
