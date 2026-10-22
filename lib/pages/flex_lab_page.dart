import 'package:flutter/material.dart';

/// 自主实践 2：弹性分配实验 —— 三栏 2:1:1 布局 + 一栏内容超长时的表现记录
class FlexLabPage extends StatelessWidget {
  const FlexLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('弹性分配实验 · Expanded 2:1:1'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── 实验 A：标准 2:1:1 ──────────────────────────────────────
          _caseCard(
            title: '实验 A：三栏 2:1:1（Expanded 按比例分配剩余空间）',
            child: Row(
              children: [
                Expanded(flex: 2, child: _bar('flex: 2', const Color(0xFF7986CB))),
                Expanded(flex: 1, child: _bar('flex: 1', const Color(0xFF4FC3F7))),
                Expanded(flex: 1, child: _bar('flex: 1', const Color(0xFFFFB74D))),
              ],
            ),
            note: '表现：三栏宽度恒为 2:1:1，与内容长短无关；'
                '剩余空间先按 flex 加权切分，再各自填满。',
          ),
          // ── 实验 B：中间一栏内容超长（允许换行）───────────────────
          _caseCard(
            title: '实验 B：中间栏内容超长（允许换行 softWrap: true）',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _bar('flex: 2', const Color(0xFF7986CB))),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4FC3F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '这一栏的文字内容特别特别长，长到远超它按比例分到的宽度，但是允许换行',
                      softWrap: true,
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: _bar('flex: 1', const Color(0xFFFFB74D))),
              ],
            ),
            note: '表现：Expanded 给中间栏的分到的宽度是“硬约束”，'
                '超长文字在栏内自动折行、栏宽不变，无溢出告警。',
          ),
          // ── 实验 C：超长内容不换行且不受 Flex 约束 ─────────────────
          _caseCard(
            title: '实验 C：超长文本不换行、放在 Expanded 之外（错误示范）',
            child: Row(
              children: [
                SizedBox(width: 60, child: _bar('固定', const Color(0xFF7986CB))),
                // 重复 12 次（约 3000px 宽），保证在任何窗口宽度下都撑破约束
                Text(
                  '这是一段不允许换行的超长文本它会撑破Row的约束，' * 12,
                  softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 11),
                ),
                SizedBox(width: 60, child: _bar('固定', const Color(0xFFFFB74D))),
              ],
            ),
            note: '表现：Row 给非 Flex 子项的是“无界”宽度约束，不换行的长文本'
                '按自身内容报尺寸，把约束装满后超出——出现黄黑溢出条纹。',
          ),
          const SizedBox(height: 8),
          Text(
            '结论：Expanded/Flexible 负责分配主轴剩余空间，但不替子内容“消化”内容——'
            '超长文本要配合 softWrap/overflow 处理，否则照样溢出。',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ].map((w) => Padding(padding: const EdgeInsets.only(bottom: 12), child: w)).toList(),
      ),
    );
  }

  Widget _bar(String text, Color color) => Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      );

  Widget _caseCard({required String title, required Widget child, required String note}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5)),
          const SizedBox(height: 10),
          child,
          const SizedBox(height: 10),
          Text(note, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}
