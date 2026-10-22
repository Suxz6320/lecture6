import 'package:flutter/material.dart';

/// 课堂案例复现：个人名片页 profile_card
///
/// 步骤二：容器美化 —— 统计条与整体卡片加 Container 装饰
/// （圆角、阴影、留白）；头像右下加 Stack+Positioned 在线状态徽标。
class ProfileCardPage extends StatelessWidget {
  const ProfileCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人名片 · profile_card'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // 页面底色用主题派生色，衬托白色卡片
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: Center(
        // 整体卡片：卡片套路（圆角 + 阴影 + 留白）
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── 头像区：Stack 层叠 + Positioned 在线状态徽标 ─────────
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  // 徽标：绿点表示在线，白描边贴合头像边缘
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
                ],
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

              // ── 统计条容器：淡靛蓝底 + 圆角；内部三个 Expanded 均分 ──
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF1FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(child: _buildStat('128', '作品')),
                    Expanded(child: _buildStat('2431', '粉丝')),
                    Expanded(child: _buildStat('86', '关注')),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── 标签云：Wrap 流式排列，放不下自动换行 ────────────────
              Wrap(
                spacing: 8, // 主轴（横向）间距
                runSpacing: 8, // 行与行之间的间距
                alignment: WrapAlignment.center,
                children: const [
                  Chip(
                    label: Text('Flutter'),
                    backgroundColor: Color(0xFFEEF1FE),
                  ),
                  Chip(label: Text('Dart'), backgroundColor: Color(0xFFEEF1FE)),
                  Chip(
                    label: Text('移动开发'),
                    backgroundColor: Color(0xFFEEF1FE),
                  ),
                  Chip(
                    label: Text('布局系统'),
                    backgroundColor: Color(0xFFEEF1FE),
                  ),
                  Chip(
                    label: Text('每日打卡'),
                    backgroundColor: Color(0xFFEEF1FE),
                  ),
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
