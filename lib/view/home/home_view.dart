// home_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetris_app/models/score.dart';
import 'package:tetris_app/view/base_view.dart'; // BaseView import
import 'package:tetris_app/view/home/home_view_model.dart'; // BLoC(ViewModel)
import 'package:tetris_app/view/home/widget/home_bottom_bar.dart';
import 'package:tetris_app/view/home/widget/score_list/score_list.dart';
import 'package:tetris_app/view/home/widget/sort_toggel_row.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    late final HomeViewModel homeViewModel = HomeViewModel(
      scoreRepository: context.read(),
    )..add(const LoadScoreList());

    // BaseView를 사용하여 HomeViewModel을 제공 + builder로 UI 구성
    return BaseView(
      // BLoC 인스턴스 생성 + 초기 이벤트 전달
      viewModel: homeViewModel,
      builder: (context, viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            automaticallyImplyLeading: false, // 뒤로 가기 버튼 제거
          ),
          bottomNavigationBar: const HomeBottomBar(),
          body: _buildBody(context, viewModel),
        );
      },
    );
  }

  // 화면의 메인 영역을 빌드
  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    // 에러가 있으면 에러 표시
    if (viewModel.state.error != null) {
      return Center(child: Text('오류: ${viewModel.state.error}'));
    }
    // 데이터가 없으면 "등록된 점수가 없습니다." 표시
    if (viewModel.state.scoreList.isEmpty) {
      return const Center(child: Text('등록된 점수가 없습니다.'));
    }

    // 최고 점수 계산
    final bestScore = _getBestScore(viewModel.state.scoreList);

    return Column(
      children: [
        // "나의 최고 기록" 텍스트
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            bestScore != null
                ? '나의 최고 기록: ${bestScore.score}점'
                : '나의 최고 기록: 없음',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        SortToggleRow(
          currentSortType: viewModel.state.sortType,
          onSortChanged: (sortType) {
            viewModel.add(SortScoreList(sortType));
          },
        ),
        const SizedBox(height: 16),

        // 점수 목록
        Expanded(
          child: ScoreList(scores: viewModel.state.scoreList), // 변경된 부분
        ),
      ],
    );
  }

  // 최고 점수 계산
  Score? _getBestScore(List<Score> scores) {
    if (scores.isEmpty) return null;
    return scores.reduce((a, b) => a.score > b.score ? a : b);
  }
}
