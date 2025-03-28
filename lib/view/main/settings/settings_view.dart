// lib/view/settings/settings_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/view/base_view.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_event.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_model.dart';
import 'package:BlockPuzzle/view/main/settings/settings_view_state.dart';
import 'package:BlockPuzzle/view/main/settings/widget/app_info_tile.dart';
import 'package:BlockPuzzle/view/main/settings/widget/change_user_id_dialog.dart';
import 'package:BlockPuzzle/view/main/settings/widget/data_management_tile.dart';
import 'package:BlockPuzzle/view/main/settings/widget/delete_confirm_dialog.dart';
import 'package:BlockPuzzle/view/main/settings/widget/user_id_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      routeName: 'settings', // 추가

      viewModel: SettingsViewModel(
        userRepository: context.read(),
        scoreService: context.read(),
      )..add(const SettingsInitialized()),
      builder: (context, viewModel) {
        return Scaffold(
          body: BlocBuilder<SettingsViewModel, SettingsViewState>(
            bloc: viewModel,
            builder: (context, state) {
              if (state.error != null) {
                return Center(child: Text(state.error!));
              }

              return ListView(
                children: [
                  // 사용자 ID 섹션
                  UserIdTile(
                    userId: state.userId,
                    onChangeIdRequested: () {
                      _showChangeUserIdModal(context, viewModel);
                    },
                  ),

                  const Divider(),

                  // 데이터 관리 섹션
                  DataManagementTile(
                    onDeleteRequested: () {
                      _showDeleteConfirmDialog(context, viewModel);
                    },
                  ),

                  const Divider(),

                  // 앱 정보 섹션
                  AppInfoTile(
                    version: state.version,
                    developer: state.developer,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmDialog(
    BuildContext context,
    SettingsViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmDialog(viewModel: viewModel),
    );
  }

  void _showChangeUserIdModal(
    BuildContext context,
    SettingsViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => ChangeUserIdDialog(viewModel: viewModel),
    );
  }
}
