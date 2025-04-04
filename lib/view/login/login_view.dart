import 'package:BlockPuzzle/repositories/user/user_repository_impl.dart';
import 'package:BlockPuzzle/utils/route_path.dart';
import 'package:BlockPuzzle/view/base_view.dart';
import 'package:BlockPuzzle/view/login/login_view_event.dart';
import 'package:BlockPuzzle/view/login/login_view_model.dart';
import 'package:BlockPuzzle/view/login/login_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      routeName: 'login',
      isGameScreen: true,
      viewModel: LoginViewModel(
        userRepository: context.read<UserRepositoryImpl>(),
      ),
      builder: (context, viewModel) {
        final state = viewModel.state;
        if (state.isSuccess) {
          // 로그인 성공 상태이면, 빌드 완료 후 홈 화면으로 전환
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, RoutePath.home);
          });
          // 네비게이션이 완료될 때까지 빈 위젯 반환
          return const SizedBox.shrink();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Login'), // 로컬라이징된 로그인 텍스트 사용
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                state.isSuccess
                    ? _buildSuccess(state)
                    : _buildLogin(context, viewModel, state),
          ),
        );
      },
    );
  }

  Widget _buildLogin(
    BuildContext context,
    LoginViewModel viewModel,
    LoginViewState state,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('아이디를 입력해주세요', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) => viewModel.add(UserIdChanged(value)),
          decoration: InputDecoration(
            labelText: 'User ID',
            border: const OutlineInputBorder(),
            errorText: state.error,
          ),
        ),
        const SizedBox(height: 16),
        state.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
              onPressed: () => viewModel.add(LoginButtonPressed()),
              child: const Text('로그인'),
            ),
      ],
    );
  }

  Widget _buildSuccess(LoginViewState state) {
    return Center(
      child: Text(
        '환영합니다, ${state.userId}님!',
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
