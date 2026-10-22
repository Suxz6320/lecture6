import 'package:flutter/material.dart';

/// 自主实践 1：对齐任务卡 —— 六种对齐场景逐一实现，参数直接标注在场景下方
class AlignmentLabPage extends StatelessWidget {
  const AlignmentLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('对齐任务卡 · 六种对齐场景'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── ① Row · 主轴 start（默认值）────────────────────────────
          _rowCase(
            label: '① Row · mainAxisAlignment.start（默认）',
            alignment: MainAxisAlignment.start,
          ),
          // ── ② Row · 主轴 center ────────────────────────────────────
          _rowCase(
            label: '② Row · mainAxisAlignment.center',
            alignment: MainAxisAlignment.center,
          ),
          // ── ③ Row · 主轴 spaceBetween：两端贴边，中间均分间隙 ───────
          _rowCase(
            label: '③ Row · mainAxisAlignment.spaceBetween',
            alignment: MainAxisAlignment.spaceBetween,
          ),
          // ── ④ Row · 主轴 spaceEvenly：含两端在内的间隙完全相等 ──────
          _rowCase(
            label: '④ Row · mainAxisAlignment.spaceEvenly',
            alignment: MainAxisAlignment.spaceEvenly,
          ),
          // ── ⑤ Column · 主轴 spaceBetween ───────────────────────────
          _columnCase(
            label: '⑤ Column · mainAxisAlignment.spaceBetween',
            alignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          // ── ⑥ Column · 交叉轴 stretch：子组件横向被拉满 ────────────
          _columnCase(
            label: '⑥ Column · crossAxisAlignment.stretch',
            alignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
          const SizedBox(height: 12),
          Text(
            '说明：每个场景由三个 56px 色块演示；主轴对齐由 mainAxisAlignment 控制，'
            '交叉轴对齐由 crossAxisAlignment 控制；参数已标注在对应场景下方。',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ].map((w) => Padding(padding: const EdgeInsets.only(bottom: 12), child: w)).toList(),
      ),
    );
  }

  /// Row 对齐场景：外层卡片 + 固定高度演示区 + 参数标注
  Widget _rowCase({required String label, required MainAxisAlignment alignment}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _demoBox(
            Row(mainAxisAlignment: alignment, children: _blocks()),
          ),
          const SizedBox(height: 8),
          _paramLabel(label),
        ],
      ),
    );
  }

  /// Column 对齐场景
  Widget _columnCase({
    required String label,
    required MainAxisAlignment alignment,
    required CrossAxisAlignment crossAxisAlignment,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _demoBox(
            SizedBox(
              // 纵向内容 3×40 + 2×6 = 132px，留足空隙让 spaceBetween 有可见间隔
              height: 180,
              child: Column(
                mainAxisAlignment: alignment,
                crossAxisAlignment: crossAxisAlignment,
                children: _blocks(),
              ),
            ),
            height: 192,
          ),
          const SizedBox(height: 8),
          _paramLabel(label),
        ],
      ),
    );
  }

  List<Widget> _blocks() => const [
        _ColorBox(color: Color(0xFF7986CB), text: 'A'),
        SizedBox(width: 6, height: 6),
        _ColorBox(color: Color(0xFF4FC3F7), text: 'B'),
        SizedBox(width: 6, height: 6),
        _ColorBox(color: Color(0xFFFFB74D), text: 'C'),
      ];

  BoxDecoration _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      );

  Widget _demoBox(Widget child, {double height = 96}) => Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFFAFAFA),
        ),
        padding: const EdgeInsets.all(6),
        child: child,
      );

  Widget _paramLabel(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFEEF1FE),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(fontFamily: 'Consolas, monospace', fontSize: 12.5, color: Color(0xFF3949AB)),
        ),
      );
}

/// 演示用小色块
class _ColorBox extends StatelessWidget {
  const _ColorBox({required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
