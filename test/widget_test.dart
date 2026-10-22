// profile_card 基础冒烟测试：
// 验证应用能正常构建，且名片页关键内容（姓名、统计条数字）渲染成功。
import 'package:flutter_test/flutter_test.dart';

import 'package:profile_card/main.dart';

void main() {
  testWidgets('profile card renders name & stats', (WidgetTester tester) async {
    await tester.pumpWidget(const ProfileCardApp());

    // 姓名与签名
    expect(find.text('李桐'), findsOneWidget);
    expect(find.text('Flutter 学习中 · 每天进步一点点'), findsOneWidget);

    // 统计条三个数字块
    expect(find.text('128'), findsOneWidget);
    expect(find.text('2431'), findsOneWidget);
    expect(find.text('86'), findsOneWidget);

    // 标签云
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
  });
}
