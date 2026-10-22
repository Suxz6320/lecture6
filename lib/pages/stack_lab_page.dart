import 'package:flutter/material.dart';

/// 自主实践 3：Stack 层叠角标实验页
///
/// 场景一：头像右下角"在线"徽标（复刻名片页套路，换成带文字的胶囊徽标）
/// 场景二：封面图左下角浮层文字（图片 + 渐变遮罩 + Positioned 文字）
class StackLabPage extends StatelessWidget {
  const StackLabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自主实践3 · Stack 层叠角标')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SceneTitle('场景一：头像右下角"在线"徽标'),
          _SceneCard(child: _AvatarBadgeScene()),
          SizedBox(height: 24),
          _SceneTitle('场景二：封面图左下角浮层文字'),
          _SceneCard(child: _ImageOverlayScene()),
        ],
      ),
    );
  }
}

/// 场景标题：页面里的小节说明
class _SceneTitle extends StatelessWidget {
  const _SceneTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }
}

/// 白色卡片容器，包住每个演示场景
class _SceneCard extends StatelessWidget {
  const _SceneCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

/// 场景一：圆形头像 + 右下角绿点 + 右上角"在线"文字胶囊
/// Stack 决定大小（取非定位子项最大尺寸），Positioned 把小件钉在角上。
class _AvatarBadgeScene extends StatelessWidget {
  const _AvatarBadgeScene();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            // 绿点徽标：白描边压在头像边缘上
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
            // 文字胶囊徽标：换到右上角，演示同一套路换位置
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Text(
                  '在线',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 场景二：封面图做底层，上面盖一层左深右浅的渐变遮罩，
/// 左下角用 Positioned 放标题与副标题——典型的"图片浮层文字"卡片。
class _ImageOverlayScene extends StatelessWidget {
  const _ImageOverlayScene();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 320,
          child: Stack(
            children: [
              // 底层：封面图
              Image.asset(
                'assets/images/cover.jpg',
                width: 320,
                height: 180,
                fit: BoxFit.cover,
              ),
              // 中层：渐变遮罩，让左下角白字可读
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.black.withValues(alpha: 0.65),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6],
                    ),
                  ),
                ),
              ),
              // 顶层：左下角浮层文字
              const Positioned(left: 12, bottom: 12, child: _OverlayText()),
            ],
          ),
        ),
      ),
    );
  }
}

/// 浮层文字：主标题一行 + 副标题一行
class _OverlayText extends StatelessWidget {
  const _OverlayText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '黄昏海岸 · 灯塔',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Stack + Positioned.fill + 渐变遮罩',
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
