import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BlockPuzzle/view/main/settings/widget/data_management_tile.dart';

void main() {
  group('DataManagementTile Widget Tests', () {
    testWidgets('renders correctly with all elements', (WidgetTester tester) async {
      bool deleteRequestCalled = false;

      // 테스트용 위젯 생성
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DataManagementTile(
              onDeleteRequested: () {
                deleteRequestCalled = true;
              },
            ),
          ),
        ),
      );

      // 1. '데이터 관리' 텍스트가 있는지 확인
      expect(find.text('데이터 관리'), findsOneWidget);

      // 2. InkWell이 있는지 확인
      expect(find.byType(InkWell), findsOneWidget);

      // 3. Container가 있는지 확인
      expect(find.byType(Container), findsOneWidget);

      // 4. 탭 동작 테스트
      await tester.tap(find.byType(InkWell));
      expect(deleteRequestCalled, true);
    });

    testWidgets('applies correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(),
            textTheme: const TextTheme(
              titleMedium: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          home: Scaffold(
            body: DataManagementTile(
              onDeleteRequested: () {},
            ),
          ),
        ),
      );

      // 스타일링 검증
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      
      expect(decoration.borderRadius, BorderRadius.circular(8.0));
      expect(decoration.border, isNotNull);
    });
  });
}
