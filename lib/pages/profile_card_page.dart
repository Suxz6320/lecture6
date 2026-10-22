import 'package:flutter/material.dart';

/// 课堂案例复现：个人名片页 profile_card
///
/// 步骤一：骨架与对齐 —— Scaffold + Column 搭结构：
/// 头像区（CircleAvatar）、姓名与签名（两行 Text）、
/// 统计条（三个 Expanded 数字块）、标签云（Wrap）。
/// 本步只管结构与对齐，不管装饰。
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人名片 · profile_card'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        // Padding 只负责留白：给卡片内容左右 24、上下 16 的安全边距
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column 按内容收缩，交由 Center 居中
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── 头像区 ──────────────────────────────────────────────
              const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              const SizedBox(height: 12),

              // ── 姓名与签名（两行 Text）──────────────────────────────
              const Text(
                '李桐',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Flutter 学习中 · 每天进步一点点',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              // ── 统计条：三个 Expanded 数字块，按 1:1:1 平分剩余宽度 ──
              Row(
                children: [
                  Expanded(child: _buildStat('128', '作品')),
                  Expanded(child: _buildStat('2431', '粉丝')),
                  Expanded(child: _buildStat('86', '关注')),
                ],
              ),
              const SizedBox(height: 16),

              // ── 标签云：Wrap 流式排列，放不下自动换行 ────────────────
              Wrap(
                spacing: 8, // 主轴（横向）间距
                runSpacing: 8, // 行与行之间的间距
                alignment: WrapAlignment.center,
                children: const [
                  Chip(label: Text('Flutter')),
                  Chip(label: Text('Dart')),
                  Chip(label: Text('移动开发')),
                  Chip(label: Text('布局系统')),
                  Chip(label: Text('每日打卡')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 统计条的单个数字块：数字在上、标签在下
  static Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }
}
