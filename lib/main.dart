import 'package:flutter/material.dart';

import 'pages/alignment_lab_page.dart';
import 'pages/flex_lab_page.dart';
import 'pages/overflow_demo_page.dart';
import 'pages/profile_card_page.dart';
import 'pages/stack_lab_page.dart';

void main() {
  // Flutter Web 默认即为哈希路由，浏览器可用 /#/alignment 直达各实验页
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'profile_card · 基础组件与布局系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      // 命名路由：名片页为首页，四个实验/存档页各自有独立地址
      routes: {
        '/': (context) => const ProfileCardPage(),
        '/alignment': (context) => const AlignmentLabPage(),
        '/flex': (context) => const FlexLabPage(),
        '/stack': (context) => const StackLabPage(),
        '/overflow': (context) => const OverflowDemoPage(),
      },
    );
  }
}
