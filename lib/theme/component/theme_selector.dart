import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:BlockPuzzle/service/theme/theme_service.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PopupMenuButton<ThemeType>(
      icon: Icon(Icons.palette, color: theme.color.primary),
      onSelected: (ThemeType themeType) {
        context.themeService.add(onChangeTheme(themeType));
      },
      color: theme.color.surface,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: theme.deco.borderRadius,
        side: BorderSide(color: theme.color.border, width: 0.5),
      ),
      itemBuilder: (BuildContext context) {
        return [
          _buildThemeItem(
            context,
            ThemeType.light,
            'Light Theme',
            Icons.brightness_5,
          ),
          _buildThemeItem(
            context,
            ThemeType.dark,
            'Dark Theme',
            Icons.brightness_3,
          ),
          _buildThemeItem(
            context,
            ThemeType.protanopia,
            'Protanopia',
            Icons.remove_red_eye,
          ),
          _buildThemeItem(
            context,
            ThemeType.tritanopia,
            'Tritanopia',
            Icons.visibility,
          ),
          _buildThemeItem(
            context,
            ThemeType.achromatopsia,
            'Achromatopsia',
            Icons.invert_colors,
          ),
        ];
      },
    );
  }

  PopupMenuItem<ThemeType> _buildThemeItem(
    BuildContext context,
    ThemeType type,
    String label,
    IconData icon,
  ) {
    final theme = context.theme;
    final themeService = BlocProvider.of<ThemeService>(context);
    final isSelected = themeService.currentThemeType == type;

    return PopupMenuItem<ThemeType>(
      value: type,
      // 선택된 항목의 배경색을 약간 강조
      child: Container(
        decoration: BoxDecoration(
          color:
              isSelected
                  ? theme.color.primary.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: theme.deco.borderRadius,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? theme.color.primary : theme.color.text,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.typo.bodyText1.copyWith(
                color: isSelected ? theme.color.primary : theme.color.text,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected) ...[
              const Spacer(),
              Icon(Icons.check, color: theme.color.primary),
            ],
          ],
        ),
      ),
    );
  }
}
