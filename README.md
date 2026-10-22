# profile_card · 基础组件与布局系统（lecture6 课堂作业）

姓名：李桐　学号：20251060003

第 6 课作业：Flutter 基础组件与布局系统。以"个人名片页 profile_card"为案例，
完成三步复现（骨架对齐 → 容器美化与 Stack 徽标 → 设计稿对照与故意溢出实验），
并完成四项自主实践扩展页。

## 运行方式

```bash
flutter pub get
flutter run -d chrome        # 或 -d web-server --web-port 8321
flutter test                 # 冒烟测试：姓名/统计数字/标签断言
```

## 页面与路由（Web 端为哈希路由）

| 路由 | 内容 | 对应任务 |
| --- | --- | --- |
| `/#/` | 个人名片页（最终版：Container 卡片 + Stack 徽标 + Expanded 统计条 + Wrap 标签云，AppBar 右上有跳转菜单） | 案例复现三步 |
| `/#/alignment` | 对齐任务卡：六种对齐场景，参数标注在场景下方 | 自主实践 1 |
| `/#/flex` | 弹性分配实验：2:1:1 / 超长换行 / 不换行溢出三组对照 | 自主实践 2 |
| `/#/stack` | Stack 层叠角标：头像徽标 + 图片浮层文字两个场景 | 自主实践 3 |
| `/#/overflow` | 故意实验存档：去掉 Expanded 后 Row 溢出的黄黑条纹 | 案例复现 步骤三证据 |

## 目录结构

```
lib/main.dart                    # 入口 + 命名路由
lib/pages/profile_card_page.dart # 名片页（案例复现最终版）
lib/pages/alignment_lab_page.dart# 对齐任务卡（自主实践1）
lib/pages/flex_lab_page.dart     # 弹性分配实验（自主实践2）
lib/pages/stack_lab_page.dart    # Stack 层叠角标（自主实践3）
lib/pages/overflow_demo_page.dart# 故意实验存档页
assets/images/                   # 头像与封面图（本地资产）
docs/screenshots/                # 运行证据截图
```

## 提交记录（对应实验步骤）

1. `chore: flutter create profile_card`
2. `feat: profile skeleton with alignment` —— 步骤一：骨架与对齐
3. `feat: card decoration & status badge` —— 步骤二：容器美化 + Stack 徽标
4. `feat: match design spec, zero overflow warnings` —— 步骤三：设计稿对照（故意实验见存档页）
5. `feat: alignment/flex/stack labs and overflow archive` —— 自主实践 1–3
6. `fix: make overflow demos trigger reliably & column demo box height` —— 截图验证后的修正
7. `docs: README & evidence screenshots`
