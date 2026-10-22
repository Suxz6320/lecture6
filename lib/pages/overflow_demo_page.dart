import 'package:flutter/material.dart';

/// 案例复现 步骤三"故意实验"的存档页：把统计条里的三个 Expanded 拿掉，
/// 三个数字块各按内容占宽，Row 总宽超出父容器约束 → RenderFlex 溢出，
/// 右侧出现黄黑斜条纹警示。
///
/// 课堂结论：Row 的总宽超过约束时，靠右侧的子项被挤出可视区，
/// Debug 模式下用黄黑条纹直观提示；修复办法是让弹性子项（Expanded）
/// 分摊剩余空间，而不是各自按内容占宽。
class OverflowDemoPage extends StatelessWidget {
  const OverflowDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('故意实验 · 去掉 Expanded 的溢出效果')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── 故意保留的溢出版本：Row 里没有 Expanded ─────────────
            Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF1FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _Stat(value: '128', label: '作品'),
                  _Stat(value: '2431', label: '粉丝'),
                  _Stat(value: '86868', label: '关注'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ── 说明文字 ────────────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '上方的统计条宽 300，三个数字块不带 Expanded、各按内容占宽，'
                '总宽超过约束 → 右侧"关注"被挤出，出现黄黑溢出条纹。\n\n'
                '修复方式：给三个子项包上 Expanded 让其均分空间，'
                '见名片页最终版（主页 /）。此页专门保留溢出现象作课堂证据。',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 无弹性、按内容占宽的数字块（与 _buildStat 类似但外面不包 Expanded）
class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
